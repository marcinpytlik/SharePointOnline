<#
.SYNOPSIS
Zrzut konfiguracji polityk Teams (meeting/messaging/app) do CSV.
.DESCRIPTION
Uwaga: zestaw cmdletów zależy od uprawnień i tego, co masz dostępne w module.
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$OutputPath
)

$ErrorActionPreference = 'Stop'
Import-Module MicrosoftTeams -ErrorAction Stop

if (-not (Test-Path $OutputPath)) { New-Item -ItemType Directory -Path $OutputPath | Out-Null }

Connect-MicrosoftTeams | Out-Null

$stamp = Get-Date -Format "yyyyMMdd_HHmmss"

function Export-Policy([string]$Name, [scriptblock]$Getter) {
  try {
    $data = & $Getter
    if ($null -ne $data) {
      $path = Join-Path $OutputPath ("Teams_" + $Name + "_" + $stamp + ".csv")
      $data | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $path
      Write-Host "OK: $path"
    }
  } catch {
    Write-Warning "Nie udało się pobrać $Name: $($_.Exception.Message)"
  }
}

Export-Policy "CsTeamsMessagingPolicy" { Get-CsTeamsMessagingPolicy }
Export-Policy "CsTeamsMeetingPolicy"   { Get-CsTeamsMeetingPolicy }
Export-Policy "CsTeamsChannelsPolicy"  { Get-CsTeamsChannelsPolicy }
Export-Policy "CsTeamsAppPermissionPolicy" { Get-CsTeamsAppPermissionPolicy }
Export-Policy "CsTeamsAppSetupPolicy" { Get-CsTeamsAppSetupPolicy }
Export-Policy "CsTeamsGuestMessagingConfiguration" { Get-CsTeamsGuestMessagingConfiguration }
Export-Policy "CsTeamsClientConfiguration" { Get-CsTeamsClientConfiguration }

Write-Host "Gotowe."
