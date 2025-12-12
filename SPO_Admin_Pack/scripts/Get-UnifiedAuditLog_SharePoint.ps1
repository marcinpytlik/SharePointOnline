<#
.SYNOPSIS
Pobiera zdarzenia z Unified Audit Log powiązane z SharePoint/OneDrive.
.DESCRIPTION
Wymaga modułu ExchangeOnlineManagement oraz uprawnień do audytu.
Uwaga: dostępność i szczegółowość audytu zależą od polityk/planów/licencji tenant'a.
.PARAMETER LookbackDays
Ile dni wstecz.
.PARAMETER OutputPath
Folder na raport CSV.
#>
[CmdletBinding()]
param(
  [int]$LookbackDays = 7,
  [Parameter(Mandatory=$true)][string]$OutputPath
)

$ErrorActionPreference = 'Stop'
Import-Module ExchangeOnlineManagement -ErrorAction Stop

if (-not (Test-Path $OutputPath)) { New-Item -ItemType Directory -Path $OutputPath | Out-Null }

Connect-ExchangeOnline -ShowBanner:$false

$end = Get-Date
$start = $end.AddDays(-1 * $LookbackDays)

# Kluczowe: RecordType=SharePointFileOperation / SharePoint / OneDrive (różnie zależnie od tenant'a)
# Idziemy po Operation, bo to jest praktyczne dla incydentów.
$operations = @(
  "FileDeleted","FileMoved","FileRenamed","FileAccessed","FileDownloaded",
  "SharingSet","AnonymousLinkCreated","SecureLinkCreated",
  "AddedToGroup","RemovedFromGroup",
  "SiteCollectionAdminAdded","SiteCollectionAdminRemoved"
)

$all = @()
foreach ($op in $operations) {
  Write-Host "Pobieranie: $op"
  try {
    $res = Search-UnifiedAuditLog -StartDate $start -EndDate $end -Operations $op -ResultSize 5000
    $all += $res
  } catch {
    Write-Warning "Nie udało się pobrać $op: $($_.Exception.Message)"
  }
}

$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$out = Join-Path $OutputPath ("UnifiedAudit_SPO_" + $stamp + ".csv")

$rows = foreach ($e in $all) {
  # AuditData jest JSON-em
  $data = $null
  try { $data = $e.AuditData | ConvertFrom-Json } catch { }

  [pscustomobject]@{
    CreationDate = $e.CreationDate
    UserId       = $e.UserIds -join ';'
    Operation    = $e.Operations -join ';'
    RecordType   = $e.RecordType
    Workload     = $e.Workload
    SiteUrl      = $data.SiteUrl
    SourceFile   = $data.SourceFileName
    SourceRelUrl = $data.SourceRelativeUrl
    ObjectId     = $data.ObjectId
    ClientIP     = $data.ClientIP
    UserAgent    = $data.UserAgent
  }
}

$rows | Sort-Object CreationDate -Descending | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $out
Write-Host "OK: $out"

Disconnect-ExchangeOnline -Confirm:$false
