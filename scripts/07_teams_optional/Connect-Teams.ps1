<#
.SYNOPSIS
Łączy się z Microsoft Teams (Teams PowerShell).
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Import-Module MicrosoftTeams -ErrorAction Stop

Write-Host "Łączenie do Microsoft Teams..."
Connect-MicrosoftTeams
Write-Host "Połączono."
