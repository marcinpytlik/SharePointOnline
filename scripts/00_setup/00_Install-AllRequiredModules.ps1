<#
.SYNOPSIS
    Instaluje moduły potrzebne do pakietu SharePointOnline_Organized.
#>
[CmdletBinding()]
param(
    [switch]$IncludeTeams
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$modules = @(
    'PnP.PowerShell',
    'Microsoft.Online.SharePoint.PowerShell',
    'Microsoft.Graph.Reports',
    'ExchangeOnlineManagement'
)

if ($IncludeTeams) { $modules += 'MicrosoftTeams' }

foreach ($module in $modules) {
    Write-Host "Installing/updating module: $module"
    Install-Module $module -Scope CurrentUser -Force -AllowClobber
}

Write-Host 'OK. Moduły zainstalowane.'
