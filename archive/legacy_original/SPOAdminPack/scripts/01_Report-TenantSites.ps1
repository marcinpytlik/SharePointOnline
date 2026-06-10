<#
.SYNOPSIS
    Raport wszystkich site collections SharePoint Online.
#>
param(
    [string]$TenantAdminUrl = 'https://tenant-admin.sharepoint.com',
    [string]$OutputRoot = 'D:\M365Reports'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir = Join-Path $OutputRoot "TenantSites_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "tenant_sites_$DateStamp.csv"

Import-Module PnP.PowerShell
Connect-PnPOnline -Url $TenantAdminUrl -Interactive

Get-PnPTenantSite -Detailed |
    Select-Object Url, Title, Template, Owner, StorageUsageCurrent, StorageMaximumLevel, LockState, SharingCapability, LastContentModifiedDate |
    Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'

Disconnect-PnPOnline
Write-Host "Report saved: $CsvPath"
