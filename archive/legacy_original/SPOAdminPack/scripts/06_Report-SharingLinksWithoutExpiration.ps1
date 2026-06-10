<#
.SYNOPSIS
    Raport linkow udostepniania bez daty wygasniecia.
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
$OutDir = Join-Path $OutputRoot "SharingLinksNoExpiration_$DateStamp"
New-Item -Path $OutDir -ItemType Directory -Force | Out-Null
$CsvPath = Join-Path $OutDir "sharing_links_without_expiration_$DateStamp.csv"
$Rows = New-Object System.Collections.Generic.List[object]

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique

foreach ($SiteUrl in $Targets) {
    Connect-PnPOnline -Url $SiteUrl -Interactive
    foreach ($Folder in $FolderSiteRelativeUrls) {
        try {
            $Files = Get-PnPFileInFolder -FolderSiteRelativeUrl $Folder -Recurse -ExcludeSystemFolders
            foreach ($File in $Files) {
                try {
                    $Links = $File | Get-PnPFileSharingLink | Where-Object { $_.ExpirationDateTime -eq $null }
                    foreach ($Link in $Links) {
                        $Rows.Add([PSCustomObject]@{
                            SiteUrl = $SiteUrl
                            Folder = $Folder
                            FileName = $File.Name
                            ServerRelativeUrl = $File.ServerRelativeUrl
                            LinkId = $Link.Id
                            LinkKind = $Link.LinkKind
                            LinkType = $Link.LinkType
                            Scope = $Link.Scope
                            Role = $Link.Role
                            AllowsAnonymousAccess = $Link.AllowsAnonymousAccess
                            RequiresPassword = $Link.RequiresPassword
                            PreventsDownload = $Link.PreventsDownload
                            WebUrl = $Link.WebUrl
                        })
                    }
                }
                catch {
                    Write-Warning "Failed sharing link check for $($File.ServerRelativeUrl): $($_.Exception.Message)"
                }
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
