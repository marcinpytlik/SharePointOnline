<#
.SYNOPSIS
    Raport udostepnien SharePoint Online i OneDrive for Business.
.DESCRIPTION
    Generuje dwa CSV:
    - sharing_links_*.csv
    - unique_permissions_*.csv
#>
param(
    [string[]]$Urls = @(),
    [string]$UrlsFile = '',
    [string]$OutputRoot = 'D:\M365SharingReports',
    [string[]]$Libraries = @(),
    [switch]$AllDocumentLibraries,
    [int]$PageSize = 500
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$RunRoot = Join-Path $OutputRoot $DateStamp
$LogsPath = Join-Path $RunRoot 'logs'
$ReportsPath = Join-Path $RunRoot 'reports'
New-Item -Path $LogsPath,$ReportsPath -ItemType Directory -Force | Out-Null
$LogFile = Join-Path $LogsPath "sharing_report_$DateStamp.log"
$SharingLinksReport = Join-Path $ReportsPath "sharing_links_$DateStamp.csv"
$UniquePermissionsReport = Join-Path $ReportsPath "unique_permissions_$DateStamp.csv"

function Write-Log([string]$Message,[string]$Level='INFO') {
    $line = "{0} [{1}] {2}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'),$Level,$Message
    Write-Host $line
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
}
function Get-TargetType([string]$Url) {
    if ($Url -match '-my\.sharepoint\.com/personal/') { return 'OneDrive' }
    return 'SharePointOnline'
}
function Get-ItemTypeFromFsObjType($FsObjType) {
    if ($FsObjType -eq 1 -or $FsObjType -eq '1') { return 'Folder' }
    if ($FsObjType -eq 0 -or $FsObjType -eq '0') { return 'File' }
    return 'ListItem'
}
function Get-RoleNames($RoleDefinitionBindings) {
    $roles = @()
    foreach ($role in $RoleDefinitionBindings) { if ($role.Name -ne 'Limited Access') { $roles += $role.Name } }
    return ($roles -join ', ')
}
function Get-ListItemUrl([string]$SiteUrl,[string]$FileRef) {
    if ([string]::IsNullOrWhiteSpace($FileRef)) { return '' }
    $base = $SiteUrl.TrimEnd('/')
    if ($FileRef.StartsWith('/')) { $uri = [System.Uri]$base; return "$($uri.Scheme)://$($uri.Host)$FileRef" }
    return "$base/$FileRef"
}

$Targets = @()
if ($Urls.Count -gt 0) { $Targets += $Urls }
if ($UrlsFile -and (Test-Path $UrlsFile)) { $Targets += Get-Content $UrlsFile | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } }
$Targets = $Targets | Select-Object -Unique
if (-not $Targets -or $Targets.Count -eq 0) { throw 'Nie podano zadnych URL-i.' }

$SharingLinkRows = New-Object System.Collections.Generic.List[object]
$UniquePermissionRows = New-Object System.Collections.Generic.List[object]

foreach ($TargetUrl in $Targets) {
    $SourceType = Get-TargetType $TargetUrl
    Write-Log "Przetwarzam: $TargetUrl [$SourceType]"
    try { Connect-PnPOnline -Url $TargetUrl -Interactive } catch { Write-Log "Blad polaczenia: $($_.Exception.Message)" 'ERROR'; continue }

    try {
        if ($AllDocumentLibraries -or $Libraries.Count -eq 0) {
            $LibrariesToScan = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 -and $_.Hidden -eq $false } | Select-Object -ExpandProperty Title
        } else { $LibrariesToScan = $Libraries }

        foreach ($LibraryName in $LibrariesToScan) {
            Write-Log "Biblioteka: $LibraryName"
            try {
                $Items = Get-PnPListItem -List $LibraryName -PageSize $PageSize -Fields 'FileRef','FileLeafRef','FSObjType','Modified','Editor','Created','Author','File_x0020_Size'
            } catch { Write-Log "Blad listy $LibraryName : $($_.Exception.Message)" 'ERROR'; continue }

            foreach ($Item in $Items) {
                $FileRef = [string]$Item.FieldValues['FileRef']
                $FileName = [string]$Item.FieldValues['FileLeafRef']
                $FsObjType = $Item.FieldValues['FSObjType']
                $ItemType = Get-ItemTypeFromFsObjType $FsObjType

                try {
                    Get-PnPProperty -ClientObject $Item -Property HasUniqueRoleAssignments, RoleAssignments | Out-Null
                    if ($Item.HasUniqueRoleAssignments -eq $true) {
                        foreach ($RoleAssignment in $Item.RoleAssignments) {
                            Get-PnPProperty -ClientObject $RoleAssignment -Property Member, RoleDefinitionBindings | Out-Null
                            $roles = Get-RoleNames $RoleAssignment.RoleDefinitionBindings
                            if (-not [string]::IsNullOrWhiteSpace($roles)) {
                                $UniquePermissionRows.Add([PSCustomObject]@{
                                    SourceType=$SourceType; SourceUrl=$TargetUrl; Library=$LibraryName; ItemType=$ItemType; FileName=$FileName;
                                    ServerRelativeUrl=$FileRef; ItemUrl=(Get-ListItemUrl $TargetUrl $FileRef);
                                    PrincipalTitle=$RoleAssignment.Member.Title; PrincipalLoginName=$RoleAssignment.Member.LoginName;
                                    PrincipalType=$RoleAssignment.Member.PrincipalType; Roles=$roles; HasUniquePermission=$true
                                })
                            }
                        }
                    }
                } catch { Write-Log "Blad unique permissions dla $FileRef : $($_.Exception.Message)" 'ERROR' }

                $IsFile = ($FsObjType -eq 0 -or $FsObjType -eq '0')
                if ($IsFile -and -not [string]::IsNullOrWhiteSpace($FileRef)) {
                    try {
                        $Links = Get-PnPFileSharingLink -Identity $FileRef -ErrorAction SilentlyContinue
                        foreach ($Link in $Links) {
                            $SharingLinkRows.Add([PSCustomObject]@{
                                SourceType=$SourceType; SourceUrl=$TargetUrl; Library=$LibraryName; ItemType='File'; FileName=$FileName;
                                ServerRelativeUrl=$FileRef; ItemUrl=(Get-ListItemUrl $TargetUrl $FileRef);
                                LinkId=$Link.Id; LinkKind=$Link.LinkKind; LinkType=$Link.LinkType; Scope=$Link.Scope; Role=$Link.Role;
                                AllowsAnonymous=$Link.AllowsAnonymousAccess; RequiresPassword=$Link.RequiresPassword;
                                ExpirationDateTime=$Link.ExpirationDateTime; PreventsDownload=$Link.PreventsDownload;
                                CreatedDateTime=$Link.CreatedDateTime; CreatedBy=$Link.CreatedBy; WebUrl=$Link.WebUrl
                            })
                        }
                    } catch { Write-Log "Blad sharing links dla $FileRef : $($_.Exception.Message)" 'ERROR' }
                }
            }
        }
    } finally {
        Disconnect-PnPOnline
    }
}

$SharingLinkRows | Export-Csv -Path $SharingLinksReport -NoTypeInformation -Encoding UTF8 -Delimiter ';'
$UniquePermissionRows | Export-Csv -Path $UniquePermissionsReport -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Write-Log "Koniec. Sharing links: $($SharingLinkRows.Count). Unique permissions: $($UniquePermissionRows.Count). Folder: $RunRoot"
