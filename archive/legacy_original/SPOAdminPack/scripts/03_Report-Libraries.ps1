<#
.SYNOPSIS
    Raport bibliotek dokumentow dla podanych witryn.
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
$OutDir = Join-Path $OutputRoot "Libraries_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "libraries_$DateStamp.csv"
$Rows = New-Object System.Collections.Generic.List[object]

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique

foreach ($SiteUrl in $Targets) {
    Write-Host "Processing $SiteUrl"
    Connect-PnPOnline -Url $SiteUrl -Interactive
    Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 } | ForEach-Object {
        $Rows.Add([PSCustomObject]@{
            SiteUrl = $SiteUrl
            Title = $_.Title
            ItemCount = $_.ItemCount
            Hidden = $_.Hidden
            EnableVersioning = $_.EnableVersioning
            EnableMinorVersions = $_.EnableMinorVersions
            ForceCheckout = $_.ForceCheckout
        })
    }
    Disconnect-PnPOnline
}

$Rows | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Write-Host "Report saved: $CsvPath"
