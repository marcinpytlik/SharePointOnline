<#
.SYNOPSIS
    Instaluje moduły wymagane przez SPOAdminPack.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$modules = @(
    'PnP.PowerShell',
    'Microsoft.Graph.Reports'
)

foreach ($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-Host "Installing module: $module"
        Install-Module $module -Scope CurrentUser -Force -AllowClobber
    }
    else {
        Write-Host "Module already installed: $module"
    }
}
