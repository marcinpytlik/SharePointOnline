<#
.SYNOPSIS
    Raport witryn z wlaczonym external sharing.
#>
param(
    [string]$TenantAdminUrl = 'https://tenant-admin.sharepoint.com',
    [string]$OutputRoot = 'D:\M365Reports'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir = Join-Path $OutputRoot "ExternalSharing_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "external_sharing_enabled_$DateStamp.csv"

Import-Module PnP.PowerShell
Connect-PnPOnline -Url $TenantAdminUrl -Interactive

Get-PnPTenantSite -Detailed |
    Where-Object { $_.SharingCapability -ne 'Disabled' } |
    Select-Object Url, Title, Owner, SharingCapability, StorageUsageCurrent, LastContentModifiedDate |
    Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'

Disconnect-PnPOnline
Write-Host "Report saved: $CsvPath"
