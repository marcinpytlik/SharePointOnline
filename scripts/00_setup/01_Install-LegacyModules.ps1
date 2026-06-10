<#
.SYNOPSIS
Instaluje wymagane moduły PowerShell do administracji SharePoint Online.
.DESCRIPTION
- Microsoft.Online.SharePoint.PowerShell (SPO Management Shell)
- PnP.PowerShell (PnP)
- ExchangeOnlineManagement (opcjonalnie: Unified Audit Log)
#>
[CmdletBinding()]
param(
  [switch]$IncludeExchangeOnline
)

$ErrorActionPreference = 'Stop'

Write-Host "== Instalacja modułów SPO =="

# PSGallery trust (bezpieczniej: nie zmieniamy permanentnie, tylko na sesję)
if (-not (Get-PSRepository -Name PSGallery -ErrorAction SilentlyContinue)) {
  throw "Nie widzę PSGallery. Sprawdź polityki i dostęp do PowerShellGet."
}

# SPO Management Shell
Write-Host "-> Microsoft.Online.SharePoint.PowerShell"
Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Force -AllowClobber

# PnP
Write-Host "-> PnP.PowerShell"
Install-Module PnP.PowerShell -Scope CurrentUser -Force

if ($IncludeExchangeOnline) {
  Write-Host "-> ExchangeOnlineManagement (dla Search-UnifiedAuditLog)"
  Install-Module ExchangeOnlineManagement -Scope CurrentUser -Force
}

Write-Host "Gotowe."
