# wymagania jak w skrypcie cleanup-spolibrary.ps1
# link do dokumencaji baseTemplate https://learn.microsoft.com/en-us/previous-versions/office/sharepoint-csom/ee541191(v=office.15)
#pwsh -NoProfile -ExecutionPolicy Bypass -File .\Cleanup-SpoLibraries.ps1 `
#  -SiteUrl "https://TENANT.sharepoint.com/sites/TEMP" `
#  -Days 30 -Recycle -WhatIf
# wszystkie biliboteki bez final oraz keep
#pwsh -File .\Cleanup-SpoLibraries.ps1 `
#  -SiteUrl "https://TENANT.sharepoint.com/sites/TEMP" `
#  -Days 30 -Recycle `
#  -ExcludeLibraries "Final","Keep"
# usun tylko wybrane biblioteki, reszte zostaw
#pwsh -File .\Cleanup-SpoLibraries.ps1 `
#  -SiteUrl "https://TENANT.sharepoint.com/sites/TEMP" `
#  -Mode SelectedLibraries `
#  -IncludeLibraries "TempDrop","Robocze" `
#  -Days 30 -Recycle -WhatIf




[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)] [string] $SiteUrl,

  # Ile dni wstecz (domyślnie 30)
  [int] $Days = 30,

  # Tryb wyboru bibliotek:
  # - AllDocumentLibraries: skanuje wszystkie biblioteki dokumentów (BaseTemplate=101) nieukryte
  # - SelectedLibraries: skanuje tylko te z -IncludeLibraries
  [ValidateSet("AllDocumentLibraries","SelectedLibraries")]
  [string] $Mode = "AllDocumentLibraries",

  # Jeśli Mode=SelectedLibraries – podaj nazwy bibliotek (Title)
  [string[]] $IncludeLibraries,

  # Zawsze możesz wykluczyć biblioteki (Title)
  [string[]] $ExcludeLibraries = @("Style Library","Form Templates","Site Assets","Site Pages"),

  # Kryterium wieku: Modified (zalecane) lub Created
  [ValidateSet("Modified","Created")]
  [string] $AgeField = "Modified",

  # Usuń do kosza (zalecane)
  [switch] $Recycle,

  # Symulacja
  [switch] $WhatIf,

  # Gdzie zapisać logi
  [string] $OutputPath = ".\reports"
)

$ErrorActionPreference = "Stop"

# --- przygotowanie ---
if (-not (Test-Path $OutputPath)) { New-Item -ItemType Directory -Path $OutputPath | Out-Null }

$stamp   = Get-Date -Format "yyyyMMdd_HHmmss"
$csvPath = Join-Path $OutputPath ("SPO_Cleanup_" + $stamp + ".csv")
$logPath = Join-Path $OutputPath ("SPO_Cleanup_" + $stamp + ".log")

function Log([string]$msg) {
  $line = "[{0}] {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss"), $msg
  Write-Host $line
  Add-Content -Path $logPath -Value $line -Encoding UTF8
}

Log "Connect-PnPOnline: $SiteUrl"
Connect-PnPOnline -Url $SiteUrl -Interactive

$cutoff = (Get-Date).AddDays(-1 * $Days)
Log "Cutoff: $cutoff (AgeField=$AgeField) Mode=$Mode Recycle=$Recycle WhatIf=$WhatIf"

# --- wybór bibliotek ---
$libs = @()

if ($Mode -eq "AllDocumentLibraries") {
  # BaseTemplate=101 => Document Library można zmienic na inne ID , jesli chcemy coś innego usuwać
  $libs = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 -and -not $_.Hidden }
} else {
  if (-not $IncludeLibraries -or $IncludeLibraries.Count -eq 0) {
    throw "Mode=SelectedLibraries wymaga parametru -IncludeLibraries"
  }
  $all = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 -and -not $_.Hidden }
  $libs = $all | Where-Object { $IncludeLibraries -contains $_.Title }
}

if ($ExcludeLibraries -and $ExcludeLibraries.Count -gt 0) {
  $libs = $libs | Where-Object { $ExcludeLibraries -notcontains $_.Title }
}

if (-not $libs -or $libs.Count -eq 0) {
  Log "Brak bibliotek do przetworzenia po filtrach Include/Exclude."
  Disconnect-PnPOnline
  return
}

Log ("Biblioteki do czyszczenia: {0}" -f ($libs.Title -join ", "))

# --- CAML do pobrania plików starszych niż cutoff ---
# FSObjType=0 => plik (foldery mają 1)
# UWAGA: To usuwa tylko pliki. Jeśli chcesz też foldery (puste/niepuste) – daj znać, dopiszemy osobną logikę.
$cutoffIso = $cutoff.ToString("s") + "Z"

$caml = @"
<View Scope='RecursiveAll'>
  <Query>
    <Where>
      <And>
        <Eq>
          <FieldRef Name='FSObjType'/>
          <Value Type='Integer'>0</Value>
        </Eq>
        <Lt>
          <FieldRef Name='$AgeField'/>
          <Value IncludeTimeValue='TRUE' Type='DateTime'>$cutoffIso</Value>
        </Lt>
      </And>
    </Where>
  </Query>
  <RowLimit>500</RowLimit>
</View>
"@

$report = New-Object System.Collections.Generic.List[object]

foreach ($lib in $libs) {
  Log "Skan biblioteki: $($lib.Title)"

  $items = @()
  try {
    $items = Get-PnPListItem -List $lib.Title -Query $caml -PageSize 500 -Fields "FileRef","FileLeafRef",$AgeField
  } catch {
    Log "WARN: Nie udało się pobrać itemów z '$($lib.Title)': $($_.Exception.Message)"
    continue
  }

  Log ("Znaleziono do usunięcia: {0}" -f $items.Count)

  foreach ($it in $items) {
    $url  = $it.FieldValues["FileRef"]
    $name = $it.FieldValues["FileLeafRef"]
    $age  = $it.FieldValues[$AgeField]

    $row = [pscustomobject]@{
      SiteUrl   = $SiteUrl
      Library   = $lib.Title
      FileName  = $name
      FileRef   = $url
      AgeField  = $AgeField
      AgeValue  = $age
      Cutoff    = $cutoff
      Action    = $WhatIf ? "WhatIf" : ($Recycle ? "Recycle" : "Delete")
      Result    = ""
      Error     = ""
    }

    if ($WhatIf) {
      $row.Result = "SKIPPED(WhatIf)"
      $report.Add($row)
      continue
    }

    try {
      if ($Recycle) {
        Remove-PnPFile -ServerRelativeUrl $url -Recycle -Force
      } else {
        Remove-PnPFile -ServerRelativeUrl $url -Force
      }
      $row.Result = "OK"
    } catch {
      $row.Result = "FAILED"
      $row.Error  = $_.Exception.Message
      Log "ERROR: $($lib.Title) :: $name :: $($row.Error)"
    }

    $report.Add($row)
  }
}

# --- zapis raportu ---
$report | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csvPath
Log "Raport CSV: $csvPath"
Log "Log: $logPath"

Disconnect-PnPOnline
Log "Done."