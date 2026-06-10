<#
.SYNOPSIS
    Raport plikow niemodyfikowanych od wskazanej liczby miesiecy.
#>
param(
    [string[]]$Urls = @(),
    [string]$UrlsFile = '.\config\sites.txt',
    [string[]]$Libraries = @('Documents','Shared Documents'),
    [int]$OlderThanMonths = 12,
    [int]$PageSize = 500,
    [string]$OutputRoot = 'D:\M365Reports'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$OutDir = Join-Path $OutputRoot "OldFiles_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "old_files_$DateStamp.csv"
$Rows = New-Object System.Collections.Generic.List[object]
$OlderThan = (Get-Date).AddMonths(-1 * $OlderThanMonths)

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique

foreach ($SiteUrl in $Targets) {
    Connect-PnPOnline -Url $SiteUrl -Interactive
    foreach ($Library in $Libraries) {
        try {
            $Items = Get-PnPListItem -List $Library -PageSize $PageSize -Fields 'FileRef','FileLeafRef','FSObjType','Modified','Editor','File_x0020_Size'
            foreach ($Item in $Items) {
                $isFile = ($Item.FieldValues['FSObjType'] -eq 0 -or $Item.FieldValues['FSObjType'] -eq '0')
                if ($isFile -and ([datetime]$Item.FieldValues['Modified'] -lt $OlderThan)) {
                    $Rows.Add([PSCustomObject]@{
                        SiteUrl = $SiteUrl
                        Library = $Library
                        FileName = $Item.FieldValues['FileLeafRef']
                        FileUrl = $Item.FieldValues['FileRef']
                        Modified = $Item.FieldValues['Modified']
                        Editor = $Item.FieldValues['Editor'].Email
                        SizeBytes = $Item.FieldValues['File_x0020_Size']
                    })
                }
            }
        }
        catch {
            Write-Warning "Failed library $Library on $SiteUrl : $($_.Exception.Message)"
        }
    }
    Disconnect-PnPOnline
}

$Rows | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Write-Host "Report saved: $CsvPath"
