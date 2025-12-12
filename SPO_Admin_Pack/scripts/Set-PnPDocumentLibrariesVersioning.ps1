<#
.SYNOPSIS
Ustawia wersjonowanie w bibliotekach dokumentów (PnP) – limit wersji, wymuszanie zatwierdzania itd.
.DESCRIPTION
Zmieniasz politykę, gdy storage rośnie przez niekontrolowane wersje.
.PARAMETER SiteUrl
.PARAMETER MaxVersions
.PARAMETER ApplyTo
AllDocumentLibraries | SelectedLibraries
.PARAMETER Libraries
Lista nazw bibliotek, gdy ApplyTo=SelectedLibraries.
#>
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
  [Parameter(Mandatory=$true)][string]$SiteUrl,
  [Parameter(Mandatory=$true)][int]$MaxVersions,
  [ValidateSet('AllDocumentLibraries','SelectedLibraries')][string]$ApplyTo = 'AllDocumentLibraries',
  [string[]]$Libraries
)

$ErrorActionPreference = 'Stop'
Import-Module PnP.PowerShell -ErrorAction Stop
Connect-PnPOnline -Url $SiteUrl -Interactive

$lists = Get-PnPList | Where-Object { $_.BaseTemplate -eq 101 -and -not $_.Hidden } # 101 = Document Library

if ($ApplyTo -eq 'SelectedLibraries') {
  if (-not $Libraries -or $Libraries.Count -eq 0) { throw "ApplyTo=SelectedLibraries wymaga -Libraries" }
  $lists = $lists | Where-Object { $Libraries -contains $_.Title }
}

foreach ($l in $lists) {
  $action = "Set versioning for '$($l.Title)' => MajorVersionLimit=$MaxVersions"
  if ($PSCmdlet.ShouldProcess($SiteUrl, $action)) {
    Set-PnPList -Identity $l -EnableVersioning $true -MajorVersions $MaxVersions | Out-Null
    Write-Host "OK: $($l.Title)"
  }
}
