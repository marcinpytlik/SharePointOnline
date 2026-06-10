- Skrypt usuwa elementy → lądują w koszu (93 dni) zanim znikną na amen. :contentReference[oaicite:5]{index=5}  
- Jeżeli masz włączone retencje/hold, usunięcie może być „miękkie” (z perspektywy użytkownika znika, ale compliance może je zachować).

### Przykładowy skrypt (PnP) – usuń pliki starsze niż 30 dni z biblioteki „Documents”
> Założenie: kasujemy po `Modified` (najbezpieczniejsze operacyjnie).  
> Działa jako „sprzątacz” dla jednej biblioteki. Rozszerzysz na wiele bibliotek/site’ów według potrzeb.

```powershell
#requires -modules PnP.PowerShell
param(
  [Parameter(Mandatory=$true)] [string] $SiteUrl,
  [Parameter(Mandatory=$true)] [string] $LibraryTitle,
  [int] $Days = 30,
  [switch] $Recycle,
  [switch] $WhatIf
)

$ErrorActionPreference = "Stop"

Connect-PnPOnline -Url $SiteUrl -Interactive

$cutoff = (Get-Date).AddDays(-1 * $Days)

# CAML: tylko pliki (FSObjType=0) i Modified < cutoff
$caml = @"
<View Scope='RecursiveAll'>
  <Query>
    <Where>
      <And>
        <Eq><FieldRef Name='FSObjType'/><Value Type='Integer'>0</Value></Eq>
        <Lt><FieldRef Name='Modified'/><Value IncludeTimeValue='TRUE' Type='DateTime'>$($cutoff.ToString("s"))Z</Value></Lt>
      </And>
    </Where>
  </Query>
  <RowLimit>500</RowLimit>
</View>
"@

$items = Get-PnPListItem -List $LibraryTitle -Query $caml -PageSize 500 -Fields "FileRef","FileLeafRef","Modified"

Write-Host "Do usunięcia: $($items.Count) (Modified < $cutoff)"

foreach ($it in $items) {
  $url = $it.FieldValues["FileRef"]
  $name = $it.FieldValues["FileLeafRef"]
  $mod = $it.FieldValues["Modified"]

  if ($WhatIf) {
    Write-Host "[WhatIf] $mod  $name  $url"
    continue
  }

  if ($Recycle) {
    # usuń do kosza
    Remove-PnPFile -ServerRelativeUrl $url -Recycle -Force
  } else {
    # usuń (w praktyce i tak przechodzi przez recycle bin – zależnie od operacji/polityk)
    Remove-PnPFile -ServerRelativeUrl $url -Force
  }

  Write-Host "OK: $name"
}

Disconnect-PnPOnline