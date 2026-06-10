<#
.SYNOPSIS
    Techniczna kopia plikow z OneDrive for Business.
.DESCRIPTION
    To nie jest pelny backup Microsoft 365/OneDrive. Skrypt kopiuje pliki z biblioteki dokumentow,
    tworzy log oraz manifest CSV.
#>
param(
    [Parameter(Mandatory=$true)][string]$OneDriveUrl,
    [string]$BackupRoot = 'D:\OneDriveBackups',
    [string]$LibraryName = 'Documents',
    [int]$PageSize = 500
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell

$DateStamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$SafeName = $OneDriveUrl -replace 'https?://','' -replace '[\\/:*?`"<>|]','_' -replace '\.','_'
$BackupPath = Join-Path $BackupRoot "$SafeName\$DateStamp"
$FilesPath = Join-Path $BackupPath 'files'
$LogsPath = Join-Path $BackupPath 'logs'
$ManifestPath = Join-Path $BackupPath 'manifest'
New-Item -Path $FilesPath,$LogsPath,$ManifestPath -ItemType Directory -Force | Out-Null
$LogFile = Join-Path $LogsPath "onedrive_backup_$DateStamp.log"
$ManifestFile = Join-Path $ManifestPath "onedrive_files_manifest_$DateStamp.csv"

function Write-Log([string]$Message,[string]$Level='INFO') {
    $line = "{0} [{1}] {2}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'),$Level,$Message
    Write-Host $line
    Add-Content -Path $LogFile -Value $line -Encoding UTF8
}
function Get-RelativeLocalPath([string]$ServerRelativeUrl,[string]$LibraryRootFolder) {
    $fileUrl = $ServerRelativeUrl.TrimStart('/')
    $root = $LibraryRootFolder.TrimStart('/')
    if ($fileUrl.StartsWith($root,[System.StringComparison]::OrdinalIgnoreCase)) { return $fileUrl.Substring($root.Length).TrimStart('/') }
    return Split-Path $ServerRelativeUrl -Leaf
}

Write-Log "Start kopii plikow OneDrive: $OneDriveUrl"
Connect-PnPOnline -Url $OneDriveUrl -Interactive
$List = Get-PnPList -Identity $LibraryName -Includes RootFolder
$LibraryRootFolder = $List.RootFolder.ServerRelativeUrl
$LibraryLocalRoot = Join-Path $FilesPath $LibraryName
New-Item -Path $LibraryLocalRoot -ItemType Directory -Force | Out-Null
$Rows = New-Object System.Collections.Generic.List[object]

$Items = Get-PnPListItem -List $LibraryName -PageSize $PageSize -Fields 'FileRef','FileLeafRef','FSObjType','Modified','Created','File_x0020_Size'
$FileItems = $Items | Where-Object { $_.FieldValues['FSObjType'] -eq 0 -or $_.FieldValues['FSObjType'] -eq '0' }
Write-Log "Liczba plikow: $($FileItems.Count)"

foreach ($Item in $FileItems) {
    $FileRef = [string]$Item.FieldValues['FileRef']
    $FileName = [string]$Item.FieldValues['FileLeafRef']
    try {
        $RelativePath = Get-RelativeLocalPath -ServerRelativeUrl $FileRef -LibraryRootFolder $LibraryRootFolder
        $RelativeFolder = Split-Path $RelativePath -Parent
        $LocalFolder = if ([string]::IsNullOrWhiteSpace($RelativeFolder)) { $LibraryLocalRoot } else { Join-Path $LibraryLocalRoot $RelativeFolder }
        New-Item -Path $LocalFolder -ItemType Directory -Force | Out-Null
        Get-PnPFile -Url $FileRef -Path $LocalFolder -FileName $FileName -AsFile -Force
        $Rows.Add([PSCustomObject]@{ OneDriveUrl=$OneDriveUrl; Library=$LibraryName; ServerRelativeUrl=$FileRef; LocalPath=(Join-Path $LocalFolder $FileName); FileName=$FileName; Created=$Item.FieldValues['Created']; Modified=$Item.FieldValues['Modified']; SizeBytes=$Item.FieldValues['File_x0020_Size']; Status='OK'; Error='' })
    } catch {
        Write-Log "Blad pobierania: $FileRef - $($_.Exception.Message)" 'ERROR'
        $Rows.Add([PSCustomObject]@{ OneDriveUrl=$OneDriveUrl; Library=$LibraryName; ServerRelativeUrl=$FileRef; LocalPath=''; FileName=$FileName; Created=$Item.FieldValues['Created']; Modified=$Item.FieldValues['Modified']; SizeBytes=$Item.FieldValues['File_x0020_Size']; Status='ERROR'; Error=$_.Exception.Message })
    }
}

$Rows | Export-Csv -Path $ManifestFile -NoTypeInformation -Encoding UTF8 -Delimiter ';'
Disconnect-PnPOnline
Write-Log "Koniec. Folder: $BackupPath"
