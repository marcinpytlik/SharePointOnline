<#
.SYNOPSIS
Łączy się z SharePoint Online Admin Center (SPO Management Shell).
.PARAMETER TenantAdminUrl
Np. https://TENANT-admin.sharepoint.com
#>
[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)][string]$TenantAdminUrl
)
$ErrorActionPreference = 'Stop'

Import-Module Microsoft.Online.SharePoint.PowerShell -ErrorAction Stop

Write-Host "Łączenie do SPO Admin: $TenantAdminUrl"
Connect-SPOService -Url $TenantAdminUrl
Write-Host "Połączono."
