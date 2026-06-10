<#
.SYNOPSIS
    Dodaje site columns z witryny głównej do bibliotek dokumentów w podwitrynach SharePoint Online.

.DESCRIPTION
    Skrypt działa dla klasycznej struktury:
    root site / subsite / subsite.

    Site columns muszą istnieć na witrynie głównej.
    Skrypt dodaje wskazane kolumny do bibliotek dokumentów w podwitrynach.

.REQUIREMENTS
    Install-Module PnP.PowerShell -Scope CurrentUser

.EXAMPLE
    .\Add-RootSiteColumns-To-SubsitesLibraries.ps1 `
        -RootSiteUrl "https://tenant.sharepoint.com/sites/Intranet" `
        -ColumnInternalNames "SQLM_Dzial","SQLM_TypDokumentu","SQLM_DataObowiazywania" `
        -AllDocumentLibraries
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$RootSiteUrl,

    [Parameter(Mandatory = $true)]
    [string[]]$ColumnInternalNames,

    [Parameter(Mandatory = $false)]
    [string[]]$LibraryNames = @(),

    [Parameter(Mandatory = $false)]
    [switch]$AllDocumentLibraries,

    [Parameter(Mandatory = $false)]
    [string]$OutputRoot = "D:\SPOReports"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$DateStamp = Get-Date -Format "yyyyMMdd_HHmmss"
$RunPath = Join-Path $OutputRoot "AddSiteColumnsToSubsites_$DateStamp"
$LogPath = Join-Path $RunPath "logs"
$ReportPath = Join-Path $RunPath "reports"

New-Item -Path $LogPath -ItemType Directory -Force | Out-Null
New-Item -Path $ReportPath -ItemType Directory -Force | Out-Null

$LogFile = Join-Path $LogPath "add_site_columns_$DateStamp.log"
$ReportFile = Join-Path $ReportPath "add_site_columns_report_$DateStamp.csv"

function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )

    $Line = "{0} [{1}] {2}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $Level, $Message
    Write-Host $Line
    Add-Content -Path $LogFile -Value $Line -Encoding UTF8
}

if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
    Write-Host "Brak modułu PnP.PowerShell. Zainstaluj:"
    Write-Host "Install-Module PnP.PowerShell -Scope CurrentUser"
    exit 1
}

Import-Module PnP.PowerShell

$Rows = New-Object System.Collections.Generic.List[object]

Write-Log "Start dodawania site columns do bibliotek w podwitrynach."
Write-Log "RootSiteUrl: $RootSiteUrl"
Write-Log "Kolumny: $($ColumnInternalNames -join ', ')"

# ------------------------------------------------------------
# 1. Pobranie XML definicji site columns z witryny głównej
# ------------------------------------------------------------

$FieldXmlByInternalName = @{}

try {
    Write-Log "Łączenie z witryną główną..."

    Connect-PnPOnline `
        -Url $RootSiteUrl `
        -Interactive

    Write-Log "Połączono z witryną główną."

    foreach ($ColumnInternalName in $ColumnInternalNames) {
        try {
            Write-Log "Pobieram site column z root site: $ColumnInternalName"

            $Field = Get-PnPField `
                -Identity $ColumnInternalName `
                -ErrorAction Stop

            $FieldXmlByInternalName[$ColumnInternalName] = $Field.SchemaXml

            Write-Log "OK: pobrano definicję kolumny: $ColumnInternalName"
        }
        catch {
            Write-Log "Nie znaleziono kolumny na root site: $ColumnInternalName" "ERROR"
            Write-Log $_.Exception.Message "ERROR"
        }
    }

    if ($FieldXmlByInternalName.Count -eq 0) {
        Write-Log "Nie pobrano żadnej kolumny. Kończę." "ERROR"
        Disconnect-PnPOnline
        exit 1
    }

    # ------------------------------------------------------------
    # 2. Pobranie podwitryn
    # ------------------------------------------------------------

    Write-Log "Pobieram listę podwitryn..."

    $SubWebs = Get-PnPSubWeb -Recurse

    Write-Log "Liczba znalezionych podwitryn: $($SubWebs.Count)"

    Disconnect-PnPOnline
}
catch {
    Write-Log "Błąd podczas pracy z root site." "ERROR"
    Write-Log $_.Exception.Message "ERROR"

    try { Disconnect-PnPOnline } catch {}
    exit 1
}

# ------------------------------------------------------------
# 3. Przetwarzanie każdej podwitryny
# ------------------------------------------------------------

foreach ($SubWeb in $SubWebs) {

    $SubSiteUrl = $SubWeb.Url

    Write-Log "============================================================"
    Write-Log "Przetwarzam podwitrynę: $SubSiteUrl"

    try {
        Connect-PnPOnline `
            -Url $SubSiteUrl `
            -Interactive

        # ------------------------------------------------------------
        # 3a. Ustalenie bibliotek
        # ------------------------------------------------------------

        if ($AllDocumentLibraries -or $LibraryNames.Count -eq 0) {
            $Libraries = Get-PnPList | Where-Object {
                $_.BaseTemplate -eq 101 -and
                $_.Hidden -eq $false
            }
        }
        else {
            $Libraries = foreach ($LibraryName in $LibraryNames) {
                Get-PnPList -Identity $LibraryName -ErrorAction SilentlyContinue
            }
        }

        if (-not $Libraries -or $Libraries.Count -eq 0) {
            Write-Log "Brak bibliotek do przetworzenia w podwitrynie." "WARN"
            Disconnect-PnPOnline
            continue
        }

        foreach ($Library in $Libraries) {

            Write-Log "Biblioteka: $($Library.Title)"

            foreach ($ColumnInternalName in $ColumnInternalNames) {

                if (-not $FieldXmlByInternalName.ContainsKey($ColumnInternalName)) {
                    continue
                }

                try {
                    # Sprawdź, czy kolumna już jest w bibliotece
                    $ExistingField = Get-PnPField `
                        -List $Library.Title `
                        -Identity $ColumnInternalName `
                        -ErrorAction SilentlyContinue

                    if ($ExistingField) {
                        Write-Log "Kolumna już istnieje w bibliotece: $ColumnInternalName"

                        $Rows.Add([PSCustomObject]@{
                            SubSiteUrl         = $SubSiteUrl
                            Library            = $Library.Title
                            ColumnInternalName = $ColumnInternalName
                            Status             = "AlreadyExists"
                            Error              = ""
                        })

                        continue
                    }

                    # Dodaj kolumnę do biblioteki na podstawie XML z root site
                    Add-PnPFieldFromXml `
                        -List $Library.Title `
                        -FieldXml $FieldXmlByInternalName[$ColumnInternalName] `
                        -ErrorAction Stop

                    Write-Log "Dodano kolumnę: $ColumnInternalName"

                    $Rows.Add([PSCustomObject]@{
                        SubSiteUrl         = $SubSiteUrl
                        Library            = $Library.Title
                        ColumnInternalName = $ColumnInternalName
                        Status             = "Added"
                        Error              = ""
                    })
                }
                catch {
                    Write-Log "Błąd dodawania kolumny $ColumnInternalName do biblioteki $($Library.Title)" "ERROR"
                    Write-Log $_.Exception.Message "ERROR"

                    $Rows.Add([PSCustomObject]@{
                        SubSiteUrl         = $SubSiteUrl
                        Library            = $Library.Title
                        ColumnInternalName = $ColumnInternalName
                        Status             = "ERROR"
                        Error              = $_.Exception.Message
                    })
                }
            }
        }

        Disconnect-PnPOnline
    }
    catch {
        Write-Log "Błąd przetwarzania podwitryny: $SubSiteUrl" "ERROR"
        Write-Log $_.Exception.Message "ERROR"

        try { Disconnect-PnPOnline } catch {}

        $Rows.Add([PSCustomObject]@{
            SubSiteUrl         = $SubSiteUrl
            Library            = ""
            ColumnInternalName = ""
            Status             = "SubsiteError"
            Error              = $_.Exception.Message
        })
    }
}

# ------------------------------------------------------------
# 4. Raport
# ------------------------------------------------------------

$Rows |
    Export-Csv `
        -Path $ReportFile `
        -NoTypeInformation `
        -Encoding UTF8 `
        -Delimiter ";"

Write-Log "Koniec."
Write-Log "Raport: $ReportFile"
Write-Log "Log: $LogFile"