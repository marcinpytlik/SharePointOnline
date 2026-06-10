<#
.SYNOPSIS
Instaluje wymagane moduły PowerShell do administracji Microsoft Teams.
.DESCRIPTION
- MicrosoftTeams (Teams PowerShell module)
- ExchangeOnlineManagement (opcjonalnie: Unified Audit Log)
#>
[CmdletBinding()]
param(
  [switch]$IncludeExchangeOnline
)

$ErrorActionPreference = 'Stop'

Write-Host "== Instalacja modułów Teams =="

Write-Host "-> MicrosoftTeams"
Install-Module MicrosoftTeams -Scope CurrentUser -Force -AllowClobber

if ($IncludeExchangeOnline) {
  Write-Host "-> ExchangeOnlineManagement (Search-UnifiedAuditLog)"
  Install-Module ExchangeOnlineManagement -Scope CurrentUser -Force
}

Write-Host "Gotowe."
