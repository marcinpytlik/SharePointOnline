<#
.SYNOPSIS
Generuje raport governance dla SharePoint Online: site'y, ownerzy, storage, sharing, lock, template, hub itp.
.DESCRIPTION
Wykorzystuje SPO Management Shell:
- Connect-SPOService
- Get-SPOSite

Wynik: CSV + Markdown summary.
.PARAMETER SettingsPath
Ścieżka do scripts/settings.json
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$SettingsPath
)

$ErrorActionPreference = 'Stop'

Import-Module (Join-Path $PSScriptRoot "helpers\SPOAdmin.Helpers.psm1") -Force

$settings = Read-Settings -SettingsPath $SettingsPath
$tenantAdminUrl = $settings.TenantAdminUrl
$outBase = Resolve-Path (Join-Path (Split-Path $SettingsPath -Parent) $settings.ReportsOutputPath) -ErrorAction SilentlyContinue
if (-not $outBase) {
  $outBase = Join-Path (Split-Path $SettingsPath -Parent) $settings.ReportsOutputPath
}
Ensure-Folder -Path $outBase

$logPath = Join-Path $outBase "SPO_GovernanceReport.log"
Write-Log "Start: Get-SPOGovernanceReport" -Path $logPath

Import-Module Microsoft.Online.SharePoint.PowerShell -ErrorAction Stop
Connect-SPOService -Url $tenantAdminUrl

$includePersonal = [bool]$settings.IncludePersonalSites

Write-Log "Pobieranie listy site'ów (IncludePersonalSite=$includePersonal)..." -Path $logPath
$sites = Get-SPOSite -Limit All -IncludePersonalSite:$includePersonal

# Normalizacja i wybór najważniejszych pól
$rows = foreach ($s in $sites) {
  [pscustomobject]@{
    Url                 = $s.Url
    Title               = $s.Title
    Template            = $s.Template
    Owner               = $s.Owner
    StorageUsageMB      = $s.StorageUsageCurrent
    StorageQuotaMB      = $s.StorageQuota
    ResourceUsage       = $s.ResourceUsageCurrent
    SharingCapability   = $s.SharingCapability
    LockState           = $s.LockState
    HubSiteId           = $s.HubSiteId
    GroupId             = $s.GroupId
    LastContentModified = $s.LastContentModifiedDate
    Status              = $s.Status
  }
}

$csvPath = Join-Path $outBase "SPO_Sites_Governance.csv"
$rows | Sort-Object StorageUsageMB -Descending | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csvPath

# proste agregacje
$total = $rows.Count
$top10 = $rows | Sort-Object StorageUsageMB -Descending | Select-Object -First 10
$sharingStats = $rows | Group-Object SharingCapability | Sort-Object Count -Descending
$templateStats = $rows | Group-Object Template | Sort-Object Count -Descending

$mdPath = Join-Path $outBase "SPO_Governance_Summary.md"
$md = @()
$md += "# SPO – Governance Summary"
$md += ""
$md += "- Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
$md += "- TenantAdminUrl: `$tenantAdminUrl`"
$md += "- Liczba site’ów: **$total**"
$md += ""
$md += "## Top 10 site’ów po zużyciu storage (MB)"
$md += ""
$md += "| Url | Title | UsageMB | QuotaMB | Sharing | Lock |"
$md += "|---|---:|---:|---:|---|---|"
foreach ($t in $top10) {
  $md += "| $($t.Url) | $($t.Title -replace '\|',' ') | $($t.StorageUsageMB) | $($t.StorageQuotaMB) | $($t.SharingCapability) | $($t.LockState) |"
}
$md += ""
$md += "## SharingCapability – rozkład"
$md += ""
$md += "| SharingCapability | Count |"
$md += "|---|---:|"
foreach ($g in $sharingStats) { $md += "| $($g.Name) | $($g.Count) |" }
$md += ""
$md += "## Template – rozkład (Top 15)"
$md += ""
$md += "| Template | Count |"
$md += "|---|---:|"
foreach ($g in ($templateStats | Select-Object -First 15)) { $md += "| $($g.Name) | $($g.Count) |" }

$md | Out-File -FilePath $mdPath -Encoding UTF8

Write-Log "Wygenerowano: $csvPath" -Path $logPath
Write-Log "Wygenerowano: $mdPath" -Path $logPath
Write-Log "Koniec." -Path $logPath

Write-Host ""
Write-Host "OK. Raporty zapisane w: $outBase"
