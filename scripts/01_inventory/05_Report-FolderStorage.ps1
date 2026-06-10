<#
.SYNOPSIS
    Raport uzycia storage dla folderow/bibliotek.
#>
param(
    [string[]]$Urls = @(),
    [string]$UrlsFile = '.\config\sites.txt',
    [string[]]$FolderSiteRelativeUrls = @('Shared Documents','Documents'),
    [string]$OutputRoot = 'D:\M365Reports'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir = Join-Path $OutputRoot "FolderStorage_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "folder_storage_$DateStamp.csv"
$Rows = New-Object System.Collections.Generic.List[object]

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique

foreach ($SiteUrl in $Targets) {
    Connect-PnPOnline -Url $SiteUrl -Interactive
    foreach ($Folder in $FolderSiteRelativeUrls) {
        try {
            Get-PnPFolderStorageMetric -FolderSiteRelativeUrl $Folder | ForEach-Object {
                $Rows.Add([PSCustomObject]@{
                    SiteUrl = $SiteUrl
                    Folder = $Folder
                    Name = $_.Name
                    TotalSize = $_.TotalSize
                    FileCount = $_.FileCount
                    LastModified = $_.LastModified
                })
            }
        }
        catch {
            Write-Warning "Failed folder $Folder on $SiteUrl : $($_.Exception.Message)"
        }
    }
    Disconnect-PnPOnline
}

$Rows | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Write-Host "Report saved: $CsvPath"
