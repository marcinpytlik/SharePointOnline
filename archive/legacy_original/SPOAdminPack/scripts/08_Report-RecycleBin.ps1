<#
.SYNOPSIS
    Raport elementow w koszu witryn SharePoint Online.
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
$OutDir = Join-Path $OutputRoot "RecycleBin_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "recycle_bin_$DateStamp.csv"
$Rows = New-Object System.Collections.Generic.List[object]

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique

foreach ($SiteUrl in $Targets) {
    Connect-PnPOnline -Url $SiteUrl -Interactive
    Get-PnPRecycleBinItem | ForEach-Object {
        $Rows.Add([PSCustomObject]@{
            SiteUrl = $SiteUrl
            Title = $_.Title
            DeletedByName = $_.DeletedByName
            DeletedDate = $_.DeletedDate
            DirName = $_.DirName
            ItemType = $_.ItemType
            Size = $_.Size
        })
    }
    Disconnect-PnPOnline
}

$Rows | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Write-Host "Report saved: $CsvPath"
