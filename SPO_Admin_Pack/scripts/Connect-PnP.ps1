<#
.SYNOPSIS
Łączy się do tenant'a SharePoint Online przez PnP.PowerShell.
.DESCRIPTION
Domyślnie tryb Interactive (device/browser). Możesz też użyć App-only (ClientId + cert) – ale to wymaga osobnej konfiguracji.
.PARAMETER SiteUrl
Url site'a (dla PnP często łączysz się per site).
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$SiteUrl
)

$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell -ErrorAction Stop

Write-Host "Łączenie PnP (Interactive) do: $SiteUrl"
Connect-PnPOnline -Url $SiteUrl -Interactive
Write-Host "Połączono."
