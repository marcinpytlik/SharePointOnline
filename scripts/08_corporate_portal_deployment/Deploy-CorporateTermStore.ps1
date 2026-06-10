<#
.SYNOPSIS
    Tworzy Term Store dla portalu korporacyjnego.

.DESCRIPTION
    Tworzy grupę terminów i zestawy:
    Departments, Document Types, Business Processes, Systems, Locations,
    Confidentiality Levels, Document Statuses, Audiences, Knowledge Areas.

    Domyślnie działa jako DRY-RUN. Realne zmiany wykonuje dopiero z parametrem -Apply.

.REQUIREMENTS
    Konto musi mieć uprawnienia do zarządzania Term Store:
    Term Store Admin, Group Manager albo Contributor.
#>

[CmdletBinding()]
param(
    [string]$ConfigPath = ".\config\corporate-termstore.json",
    [Parameter(Mandatory = $true)]
    [string]$AdminUrl,
    [string]$ClientId,
    [switch]$Apply
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step([string]$Message) { Write-Host ""; Write-Host "==> $Message" -ForegroundColor Cyan }
function Write-Plan([string]$Message) { Write-Host "[PLAN] $Message" -ForegroundColor Yellow }
function Write-Do([string]$Message) { Write-Host "[WYKONANIE] $Message" -ForegroundColor Green }

function Assert-PnPModule {
    if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
        throw "Brak modułu PnP.PowerShell. Uruchom: Install-Module PnP.PowerShell -Scope CurrentUser -AllowClobber"
    }
    Import-Module PnP.PowerShell -ErrorAction Stop
}

function Connect-SpoAdmin {
    if (-not $Apply) {
        Write-Plan "Connect-PnPOnline: $AdminUrl"
        return
    }

    if ([string]::IsNullOrWhiteSpace($ClientId)) {
        Connect-PnPOnline -Url $AdminUrl -Interactive
    } else {
        Connect-PnPOnline -Url $AdminUrl -Interactive -ClientId $ClientId
    }
}

function Ensure-TermGroup($Group) {
    Write-Step "Term Group: $($Group.Name)"

    if (-not $Apply) {
        Write-Plan "New-PnPTermGroup -Name '$($Group.Name)'"
        return
    }

    $existing = Get-PnPTermGroup -Identity $Group.Name -ErrorAction SilentlyContinue
    if ($existing) {
        Write-Host "Term Group już istnieje: $($Group.Name)" -ForegroundColor DarkYellow
        return
    }

    Write-Do "Tworzenie Term Group: $($Group.Name)"
    New-PnPTermGroup -Name $Group.Name -Description $Group.Description | Out-Null
}

function Ensure-TermSet([string]$GroupName, $SetDef) {
    Write-Step "Term Set: $($SetDef.Name)"

    if (-not $Apply) {
        Write-Plan "New-PnPTermSet -Name '$($SetDef.Name)' -TermGroup '$GroupName'"
        foreach ($t in @($SetDef.Terms)) { Write-Plan "  New-PnPTerm '$t'" }
        return
    }

    $existingSet = Get-PnPTermSet -Identity $SetDef.Name -TermGroup $GroupName -ErrorAction SilentlyContinue
    if (-not $existingSet) {
        Write-Do "Tworzenie Term Set: $($SetDef.Name)"
        New-PnPTermSet -Name $SetDef.Name -TermGroup $GroupName -Description $SetDef.Description -IsOpenForTermCreation | Out-Null
    } else {
        Write-Host "Term Set już istnieje: $($SetDef.Name)" -ForegroundColor DarkYellow
    }

    foreach ($termName in @($SetDef.Terms)) {
        $existingTerm = Get-PnPTerm -Identity $termName -TermSet $SetDef.Name -TermGroup $GroupName -ErrorAction SilentlyContinue
        if ($existingTerm) {
            Write-Host "  Termin już istnieje: $termName" -ForegroundColor DarkYellow
            continue
        }

        Write-Do "  Tworzenie terminu: $termName"
        New-PnPTerm -TermSet $SetDef.Name -TermGroup $GroupName -Name $termName | Out-Null
    }
}

function Main {
    Assert-PnPModule
    if (-not (Test-Path $ConfigPath)) { throw "Nie znaleziono konfiguracji: $ConfigPath" }

    $cfg = Get-Content -Path $ConfigPath -Raw -Encoding UTF8 | ConvertFrom-Json

    Write-Host ""
    Write-Host "Corporate Portal Term Store Deployment" -ForegroundColor White
    Write-Host "Tryb: $(if ($Apply) { 'WYKONANIE' } else { 'DRY-RUN / PLAN' })" -ForegroundColor White

    Connect-SpoAdmin
    Ensure-TermGroup -Group $cfg.TermGroup

    foreach ($set in @($cfg.TermSets)) {
        Ensure-TermSet -GroupName $cfg.TermGroup.Name -SetDef $set
    }

    Write-Host ""
    Write-Host "Zakończono." -ForegroundColor Green
    if (-not $Apply) { Write-Host "To był tryb planu. Aby wykonać zmiany, dodaj parametr -Apply." -ForegroundColor Yellow }
}
Main
