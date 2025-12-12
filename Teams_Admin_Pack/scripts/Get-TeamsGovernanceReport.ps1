<#
.SYNOPSIS
Generuje raport governance dla Microsoft Teams: lista Teamów, visibility, archived, ownerzy, liczba kanałów.
.DESCRIPTION
Używa MicrosoftTeams PowerShell module:
- Connect-MicrosoftTeams
- Get-Team
- Get-TeamUser
- Get-TeamChannel

Wynik: CSV + Markdown summary.
.PARAMETER SettingsPath
Ścieżka do scripts/settings.json
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$SettingsPath
)

$ErrorActionPreference = 'Stop'

Import-Module (Join-Path $PSScriptRoot "helpers\TeamsAdmin.Helpers.psm1") -Force

$settings = Read-Settings -SettingsPath $SettingsPath
$outBase = Join-Path (Split-Path $SettingsPath -Parent) $settings.ReportsOutputPath
Ensure-Folder -Path $outBase

$logPath = Join-Path $outBase "Teams_GovernanceReport.log"
Write-Log "Start: Get-TeamsGovernanceReport" -Path $logPath

Import-Module MicrosoftTeams -ErrorAction Stop
Connect-MicrosoftTeams | Out-Null

$threads = [int]$settings.Teams.NumberOfThreads
$includeArchived = [bool]$settings.Teams.IncludeArchived

Write-Log "Pobieranie listy Teamów (threads=$threads)..." -Path $logPath
$teams = Get-Team -NumberOfThreads $threads

if (-not $includeArchived) {
  $teams = $teams | Where-Object { $_.Archived -ne $true }
}

$teamRows = @()
$ownerRows = @()
$channelRows = @()

foreach ($t in $teams) {
  $gid = $t.GroupId
  $display = $t.DisplayName

  Write-Log "Team: $display ($gid)" -Path $logPath

  $owners = @()
  try {
    $owners = Get-TeamUser -GroupId $gid | Where-Object { $_.Role -eq 'Owner' }
  } catch {
    Write-Log "WARN: Get-TeamUser failed for $gid: $($_.Exception.Message)" -Level WARN -Path $logPath
  }

  foreach ($o in $owners) {
    $ownerRows += [pscustomobject]@{
      GroupId     = $gid
      TeamName    = $display
      OwnerName   = $o.Name
      OwnerUPN    = $o.User
      Role        = $o.Role
    }
  }

  $channels = @()
  try {
    $channels = Get-TeamChannel -GroupId $gid
  } catch {
    Write-Log "WARN: Get-TeamChannel failed for $gid: $($_.Exception.Message)" -Level WARN -Path $logPath
  }

  foreach ($c in $channels) {
    $channelRows += [pscustomobject]@{
      GroupId  = $gid
      TeamName = $display
      Channel  = $c.DisplayName
      Description = $c.Description
      MembershipType = $c.MembershipType
    }
  }

  $teamRows += [pscustomobject]@{
    GroupId      = $gid
    DisplayName  = $display
    Description  = $t.Description
    Visibility   = $t.Visibility
    Archived     = $t.Archived
    MailNickName = $t.MailNickName
    Classification = $t.Classification
    OwnersCount  = ($owners | Measure-Object).Count
    ChannelsCount = ($channels | Measure-Object).Count
  }
}

$csvTeams = Join-Path $outBase "Teams_Teams.csv"
$csvOwners = Join-Path $outBase "Teams_Owners.csv"
$csvChannels = Join-Path $outBase "Teams_Channels.csv"

$teamRows | Sort-Object DisplayName | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csvTeams
$ownerRows | Sort-Object TeamName, OwnerUPN | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csvOwners
$channelRows | Sort-Object TeamName, Channel | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csvChannels

# Summary
$total = $teamRows.Count
$arch = ($teamRows | Where-Object Archived -eq $true | Measure-Object).Count
$noOwners = ($teamRows | Where-Object OwnersCount -lt 2 | Measure-Object).Count
$topChannels = $teamRows | Sort-Object ChannelsCount -Descending | Select-Object -First 10
$visStats = $teamRows | Group-Object Visibility | Sort-Object Count -Descending

$mdPath = Join-Path $outBase "Teams_Governance_Summary.md"
$md = @()
$md += "# Microsoft Teams – Governance Summary"
$md += ""
$md += "- Data: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
$md += "- Liczba Teamów: **$total**"
$md += "- Zarchiwizowane: **$arch**"
$md += "- Teamów z < 2 ownerami: **$noOwners**"
$md += ""
$md += "## Rozkład Visibility"
$md += ""
$md += "| Visibility | Count |"
$md += "|---|---:|"
foreach ($g in $visStats) { $md += "| $($g.Name) | $($g.Count) |" }
$md += ""
$md += "## Top 10 Teamów po liczbie kanałów"
$md += ""
$md += "| Team | Channels | Owners | Archived |"
$md += "|---|---:|---:|---|"
foreach ($x in $topChannels) {
  $md += "| $($x.DisplayName -replace '\|',' ') | $($x.ChannelsCount) | $($x.OwnersCount) | $($x.Archived) |"
}

$md | Out-File -FilePath $mdPath -Encoding UTF8

Write-Log "Wygenerowano: $csvTeams" -Path $logPath
Write-Log "Wygenerowano: $csvOwners" -Path $logPath
Write-Log "Wygenerowano: $csvChannels" -Path $logPath
Write-Log "Wygenerowano: $mdPath" -Path $logPath
Write-Log "Koniec." -Path $logPath

Write-Host ""
Write-Host "OK. Raporty zapisane w: $outBase"
