<#
.SYNOPSIS
Pobiera zdarzenia z Unified Audit Log dla Microsoft Teams.
.DESCRIPTION
Wymaga modułu ExchangeOnlineManagement oraz uprawnień do audytu.
Używa Search-UnifiedAuditLog z -RecordType MicrosoftTeams.
.PARAMETER LookbackDays
Ile dni wstecz.
.PARAMETER OutputPath
Folder na raport CSV.
.PARAMETER UseReturnLargeSet
Użyj SessionCommand ReturnLargeSet (do 50k wyników, bez sortowania).
.PARAMETER SessionId
Id sesji dla ReturnLargeSet.
#>
[CmdletBinding()]
param(
  [int]$LookbackDays = 7,
  [Parameter(Mandatory=$true)][string]$OutputPath,
  [switch]$UseReturnLargeSet,
  [string]$SessionId = "TeamsAuditSearch"
)

$ErrorActionPreference = 'Stop'
Import-Module ExchangeOnlineManagement -ErrorAction Stop

if (-not (Test-Path $OutputPath)) { New-Item -ItemType Directory -Path $OutputPath | Out-Null }

Connect-ExchangeOnline -ShowBanner:$false

$end = Get-Date
$start = $end.AddDays(-1 * $LookbackDays)

$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$out = Join-Path $OutputPath ("UnifiedAudit_Teams_" + $stamp + ".csv")

$cmd = @{
  StartDate = $start
  EndDate   = $end
  RecordType = "MicrosoftTeams"
  ResultSize = 5000
}
if ($UseReturnLargeSet) {
  $cmd["SessionId"] = $SessionId
  $cmd["SessionCommand"] = "ReturnLargeSet"
}

Write-Host "Pobieranie audytu Teams: $($start) -> $($end)"
$events = Search-UnifiedAuditLog @cmd

$rows = foreach ($e in $events) {
  $data = $null
  try { $data = $e.AuditData | ConvertFrom-Json } catch { }

  [pscustomobject]@{
    CreationDate = $e.CreationDate
    UserId       = $e.UserIds -join ';'
    Operation    = $e.Operations -join ';'
    RecordType   = $e.RecordType
    Workload     = $e.Workload
    TeamName     = $data.TeamName
    ChannelName  = $data.ChannelName
    ChatName     = $data.ChatName
    ObjectId     = $data.ObjectId
    ClientIP     = $data.ClientIP
    UserAgent    = $data.UserAgent
  }
}

$rows | Sort-Object CreationDate -Descending | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $out
Write-Host "OK: $out"

Disconnect-ExchangeOnline -Confirm:$false
