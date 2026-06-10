<#
.SYNOPSIS
    Czyści stare pliki z bibliotek dokumentów SharePoint Online według konfiguracji JSON.

.DESCRIPTION
    Wersja uporządkowana na bazie wcześniejszego cleanup-spolibraryv3.ps1.
    Domyślnie działa w trybie WhatIf z pliku konfiguracyjnego, więc najpierw generuje raport bez usuwania.

.EXAMPLE
    .\Cleanup-SpoLibraries.ps1 -SettingsPath .\config\cleanup.settings.example.json
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SettingsPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Read-Settings {
    param([Parameter(Mandatory = $true)][string]$Path)
    if (-not (Test-Path $Path)) { throw "Brak pliku ustawień: $Path" }
    return (Get-Content -Path $Path -Raw -Encoding UTF8 | ConvertFrom-Json)
}

function Ensure-Folder {
    param([Parameter(Mandatory = $true)][string]$Path)
    if (-not (Test-Path $Path)) { New-Item -ItemType Directory -Path $Path -Force | Out-Null }
}

function Write-CleanupLog {
    param([string]$Message)
    $line = "[{0}] {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
    Write-Host $line
    Add-Content -Path $script:LogPath -Value $line -Encoding UTF8
}

$cfg = Read-Settings -Path $SettingsPath

if (-not $cfg.SiteUrl -and $cfg.SiteURL) { $cfg | Add-Member -NotePropertyName SiteUrl -NotePropertyValue $cfg.SiteURL -Force }
if (-not $cfg.SiteUrl -or [string]::IsNullOrWhiteSpace([string]$cfg.SiteUrl)) { throw 'Brak SiteUrl w pliku ustawień.' }

$SiteUrl = [string]$cfg.SiteUrl
$Days = if ($cfg.Days) { [int]$cfg.Days } else { 30 }
$Mode = if ($cfg.Mode) { [string]$cfg.Mode } else { 'AllDocumentLibraries' }
$IncludeLibraries = if ($cfg.IncludeLibraries) { @($cfg.IncludeLibraries) } else { @() }
$ExcludeLibraries = if ($cfg.ExcludeLibraries) { @($cfg.ExcludeLibraries) } else { @('Style Library','Form Templates','Site Assets','Site Pages') }
$AgeField = if ($cfg.AgeField) { [string]$cfg.AgeField } else { 'Modified' }
$Recycle = if ($null -ne $cfg.Recycle) { [bool]$cfg.Recycle } else { $true }
$WhatIfMode = if ($null -ne $cfg.WhatIf) { [bool]$cfg.WhatIf } else { $true }
$OutputPath = if ($cfg.OutputPath) { [string]$cfg.OutputPath } else { '.\output\cleanup' }

if ($Mode -notin @('AllDocumentLibraries','SelectedLibraries')) { throw "Nieprawidłowy Mode: $Mode" }
if ($AgeField -notin @('Modified','Created')) { throw "Nieprawidłowy AgeField: $AgeField" }
if ($Mode -eq 'SelectedLibraries' -and $IncludeLibraries.Count -eq 0) { throw 'Mode=SelectedLibraries wymaga IncludeLibraries.' }

Ensure-Folder -Path $OutputPath
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$script:LogPath = Join-Path $OutputPath "SPO_Cleanup_$stamp.log"
$CsvPath = Join-Path $OutputPath "SPO_Cleanup_$stamp.csv"

Import-Module PnP.PowerShell -ErrorAction Stop

Write-CleanupLog "Connect-PnPOnline: $SiteUrl"
Connect-PnPOnline -Url $SiteUrl -Interactive

$cutoff = (Get-Date).AddDays(-1 * $Days)
$cutoffIso = $cutoff.ToUniversalTime().ToString('s') + 'Z'
Write-CleanupLog "Cutoff: $cutoffIso; AgeField=$AgeField; Mode=$Mode; Recycle=$Recycle; WhatIf=$WhatIfMode"

if ($Mode -eq 'AllDocumentLibraries') {
    $libs = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 -and -not $_.Hidden }
} else {
    $all = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 -and -not $_.Hidden }
    $libs = $all | Where-Object { $IncludeLibraries -contains $_.Title }
}

if ($ExcludeLibraries.Count -gt 0) { $libs = $libs | Where-Object { $ExcludeLibraries -notcontains $_.Title } }
if (-not $libs -or $libs.Count -eq 0) {
    Write-CleanupLog 'Brak bibliotek do przetworzenia po filtrach.'
    Disconnect-PnPOnline
    return
}

Write-CleanupLog ("Biblioteki do czyszczenia: {0}" -f (($libs | Select-Object -ExpandProperty Title) -join ', '))

$caml = @"
<View Scope='RecursiveAll'>
  <Query>
    <Where>
      <And>
        <Eq><FieldRef Name='FSObjType'/><Value Type='Integer'>0</Value></Eq>
        <Lt><FieldRef Name='$AgeField'/><Value IncludeTimeValue='TRUE' Type='DateTime'>$cutoffIso</Value></Lt>
      </And>
    </Where>
  </Query>
  <RowLimit>500</RowLimit>
</View>
"@

$report = New-Object System.Collections.Generic.List[object]

foreach ($lib in $libs) {
    Write-CleanupLog "Skan biblioteki: $($lib.Title)"
    try {
        $items = Get-PnPListItem -List $lib.Title -Query $caml -PageSize 500 -Fields 'FileRef','FileLeafRef',$AgeField
    } catch {
        Write-CleanupLog "WARN: Nie udało się pobrać itemów z '$($lib.Title)': $($_.Exception.Message)"
        continue
    }

    Write-CleanupLog ("Znaleziono kandydatów: {0}" -f $items.Count)

    foreach ($it in $items) {
        $url = [string]$it.FieldValues['FileRef']
        $name = [string]$it.FieldValues['FileLeafRef']
        $age = $it.FieldValues[$AgeField]
        $action = if ($WhatIfMode) { 'WhatIf' } elseif ($Recycle) { 'Recycle' } else { 'Delete' }

        $row = [pscustomobject]@{
            SiteUrl = $SiteUrl
            Library = $lib.Title
            FileName = $name
            FileRef = $url
            AgeField = $AgeField
            AgeValue = $age
            Cutoff = $cutoff
            Action = $action
            Result = ''
            Error = ''
        }

        if ($WhatIfMode) {
            $row.Result = 'SKIPPED(WhatIf)'
            $report.Add($row)
            continue
        }

        try {
            if ($Recycle) { Remove-PnPFile -ServerRelativeUrl $url -Recycle -Force }
            else { Remove-PnPFile -ServerRelativeUrl $url -Force }
            $row.Result = 'OK'
        } catch {
            $row.Result = 'FAILED'
            $row.Error = $_.Exception.Message
            Write-CleanupLog "ERROR: $($lib.Title) :: $name :: $($row.Error)"
        }
        $report.Add($row)
    }
}

$report | Export-Csv -NoTypeInformation -Encoding UTF8 -Delimiter ';' -Path $CsvPath
Write-CleanupLog "Raport CSV: $CsvPath"
Write-CleanupLog "Log: $script:LogPath"

Disconnect-PnPOnline
Write-CleanupLog 'Done.'
