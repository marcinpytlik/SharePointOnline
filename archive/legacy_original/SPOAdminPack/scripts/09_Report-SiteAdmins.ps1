<#
.SYNOPSIS
    Raport administratorow site collection.
#>
param(
    [string[]]$Urls = @(),
    [string]$UrlsFile = '.\config\sites.txt',
    [string]$OutputRoot = 'D:\M365Reports'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir = Join-Path $OutputRoot "SiteAdmins_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "site_collection_admins_$DateStamp.csv"
$Rows = New-Object System.Collections.Generic.List[object]

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique

foreach ($SiteUrl in $Targets) {
    Connect-PnPOnline -Url $SiteUrl -Interactive
    Get-PnPSiteCollectionAdmin | ForEach-Object {
        $Rows.Add([PSCustomObject]@{
            SiteUrl = $SiteUrl
            Title = $_.Title
            LoginName = $_.LoginName
            Email = $_.Email
            PrincipalType = $_.PrincipalType
        })
    }
    Disconnect-PnPOnline
}

$Rows | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Write-Host "Report saved: $CsvPath"
