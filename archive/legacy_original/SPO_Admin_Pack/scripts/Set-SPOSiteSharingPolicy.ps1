<#
.SYNOPSIS
Ustawia SharingCapability dla wskazanych site’ów (ostrożnie).
.DESCRIPTION
Wymaga SharePoint Admin Center i uprawnień SharePoint Administrator.
Skrypt obsługuje -WhatIf oraz -Confirm (standard PowerShell).
.PARAMETER TenantAdminUrl
.PARAMETER CsvPath
CSV z kolumną Url.
.PARAMETER SharingCapability
Disabled | ExistingExternalUserSharingOnly | ExternalUserSharingOnly | ExternalUserAndGuestSharing
#>
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
  [Parameter(Mandatory=$true)][string]$TenantAdminUrl,
  [Parameter(Mandatory=$true)][string]$CsvPath,
  [Parameter(Mandatory=$true)]
  [ValidateSet('Disabled','ExistingExternalUserSharingOnly','ExternalUserSharingOnly','ExternalUserAndGuestSharing')]
  [string]$SharingCapability
)

$ErrorActionPreference = 'Stop'
Import-Module Microsoft.Online.SharePoint.PowerShell -ErrorAction Stop

if (-not (Test-Path $CsvPath)) { throw "Brak CSV: $CsvPath" }

Connect-SPOService -Url $TenantAdminUrl

$rows = Import-Csv -Path $CsvPath
foreach ($r in $rows) {
  $url = $r.Url
  if (-not $url) { continue }

  if ($PSCmdlet.ShouldProcess($url, "Set SharingCapability=$SharingCapability")) {
    Set-SPOSite -Identity $url -SharingCapability $SharingCapability
    Write-Host "OK: $url"
  }
}
