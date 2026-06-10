<#
.SYNOPSIS
    Wdraża strukturę portalu korporacyjnego SharePoint Online:
    - Home Site,
    - Hub Site: Portal korporacyjny,
    - witryny powiązane,
    - biblioteki i listy,
    - nawigację główną huba.

.DESCRIPTION
    Domyślnie skrypt działa w trybie DRY-RUN i tylko pokazuje plan.
    Realne wykonanie następuje po dodaniu parametru -Apply.

.WYMAGANIA
    PowerShell 7.x
    Install-Module PnP.PowerShell -Scope CurrentUser -AllowClobber

.PRZYKŁAD
    .\Deploy-CorporatePortal.ps1 -ConfigPath ..\config\corporate-portal.structure.json

.PRZYKŁAD
    .\Deploy-CorporatePortal.ps1 `
      -ConfigPath ..\config\corporate-portal.structure.json `
      -ClientId "00000000-0000-0000-0000-000000000000" `
      -Apply
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$ConfigPath = "..\config\corporate-portal.structure.json",

    [Parameter(Mandatory = $false)]
    [string]$ClientId,

    [Parameter(Mandatory = $false)]
    [switch]$Apply
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Write-Plan {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host "[PLAN] $Message" -ForegroundColor Yellow
}

function Write-Do {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    Write-Host "[WYKONANIE] $Message" -ForegroundColor Green
}

function Assert-PnPModule {
    if (-not (Get-Module -ListAvailable -Name PnP.PowerShell)) {
        throw "Brak modułu PnP.PowerShell. Uruchom: Install-Module PnP.PowerShell -Scope CurrentUser -AllowClobber"
    }

    Import-Module PnP.PowerShell -ErrorAction Stop
}

function Connect-Spo {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Url
    )

    if (-not $Apply) {
        Write-Plan "Połączenie PnPOnline: $Url"
        return
    }

    if ([string]::IsNullOrWhiteSpace($ClientId)) {
        Connect-PnPOnline -Url $Url -Interactive
    }
    else {
        Connect-PnPOnline -Url $Url -Interactive -ClientId $ClientId
    }
}

function Get-TargetUrl {
    param(
        [Parameter(Mandatory = $true)]
        $Tenant,

        [Parameter(Mandatory = $true)]
        $Site
    )

    if (-not [string]::IsNullOrWhiteSpace($Site.Url)) {
        return $Site.Url
    }

    return "$($Tenant.RootUrl.TrimEnd('/'))/sites/$($Site.Alias)"
}

function Ensure-ModernSite {
    param(
        [Parameter(Mandatory = $true)]
        $Tenant,

        [Parameter(Mandatory = $true)]
        $Site
    )

    $url = Get-TargetUrl -Tenant $Tenant -Site $Site

    Write-Step "Witryna: $($Site.Title) [$($Site.Type)]"

    if (-not $Apply) {
        Write-Plan "Utworzenie lub pominięcie istniejącej witryny: $url"
        return $url
    }

    $existing = $null

    try {
        $existing = Get-PnPTenantSite -Url $url -ErrorAction Stop
    }
    catch {
        $existing = $null
    }

    if ($existing) {
        Write-Host "Witryna już istnieje: $url" -ForegroundColor DarkYellow
        return $url
    }

    Write-Do "Tworzenie witryny: $url"

    switch ($Site.Type) {
        "CommunicationSite" {
            New-PnPSite `
                -Type CommunicationSite `
                -Title $Site.Title `
                -Url $url `
                -Description $Site.Description | Out-Null
        }

        "TeamSite" {
            New-PnPSite `
                -Type TeamSite `
                -Title $Site.Title `
                -Alias $Site.Alias `
                -Description $Site.Description | Out-Null
        }

        "TeamSiteWithoutMicrosoft365Group" {
            New-PnPSite `
                -Type TeamSiteWithoutMicrosoft365Group `
                -Title $Site.Title `
                -Url $url `
                -Description $Site.Description | Out-Null
        }

        default {
            throw "Nieobsługiwany typ witryny: $($Site.Type)"
        }
    }

    Start-Sleep -Seconds 15

    return $url
}

function Register-HubSiteIfNeeded {
    param(
        [Parameter(Mandatory = $true)]
        [string]$HubUrl,

        [Parameter(Mandatory = $false)]
        [string[]]$Principals
    )

    Write-Step "Rejestracja Hub Site"

    if (-not $Apply) {
        Write-Plan "Register-PnPHubSite -Site $HubUrl"

        if ($Principals -and $Principals.Count -gt 0) {
            Write-Plan "Grant-PnPHubSiteRights: $($Principals -join ', ')"
        }

        return
    }

    $existingHub = $null

    try {
        $existingHub = Get-PnPHubSite -Identity $HubUrl -ErrorAction Stop
    }
    catch {
        $existingHub = $null
    }

    if ($existingHub) {
        Write-Host "Hub Site już istnieje: $HubUrl" -ForegroundColor DarkYellow
    }
    else {
        Write-Do "Register-PnPHubSite -Site $HubUrl"
        Register-PnPHubSite -Site $HubUrl | Out-Null
    }

    if ($Principals -and $Principals.Count -gt 0) {
        Write-Do "Grant-PnPHubSiteRights"
        Grant-PnPHubSiteRights -Identity $HubUrl -Principals $Principals | Out-Null
    }
}

function Set-HomeSiteIfNeeded {
    param(
        [Parameter(Mandatory = $true)]
        [string]$HomeSiteUrl,

        [Parameter(Mandatory = $true)]
        [bool]$VivaConnectionsDefaultStart
    )

    Write-Step "Ustawienie Home Site"

    if (-not $Apply) {
        Write-Plan "Set-PnPHomeSite -HomeSiteUrl $HomeSiteUrl -VivaConnectionsDefaultStart:`$$VivaConnectionsDefaultStart"
        return
    }

    Write-Do "Set-PnPHomeSite"
    Set-PnPHomeSite `
        -HomeSiteUrl $HomeSiteUrl `
        -VivaConnectionsDefaultStart:$VivaConnectionsDefaultStart | Out-Null
}

function Associate-ToHub {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SiteUrl,

        [Parameter(Mandatory = $true)]
        [string]$HubUrl
    )

    if ($SiteUrl.TrimEnd('/').ToLowerInvariant() -eq $HubUrl.TrimEnd('/').ToLowerInvariant()) {
        return
    }

    Write-Step "Powiązanie z hubem: $SiteUrl"

    if (-not $Apply) {
        Write-Plan "Add-PnPHubSiteAssociation -Site $SiteUrl -HubSite $HubUrl"
        return
    }

    # Weryfikujemy, czy hub jest realnie widoczny i ma ID,
    # ale do Add-PnPHubSiteAssociation przekazujemy URL huba, nie ID.
    $hub = $null

    for ($i = 1; $i -le 5; $i++) {
        $hub = Get-PnPHubSite |
            Where-Object {
                $_.SiteUrl.TrimEnd('/').ToLowerInvariant() -eq $HubUrl.TrimEnd('/').ToLowerInvariant()
            } |
            Select-Object -First 1

        if ($null -ne $hub -and -not [string]::IsNullOrWhiteSpace([string]$hub.ID)) {
            break
        }

        Write-Host "Hub nie jest jeszcze widoczny na liście Get-PnPHubSite. Próba $i/5. Czekam 30 sekund..." -ForegroundColor DarkYellow
        Start-Sleep -Seconds 30
    }

    if ($null -eq $hub -or [string]::IsNullOrWhiteSpace([string]$hub.ID)) {
        throw "Nie znaleziono poprawnie zarejestrowanego Hub Site z ID: $HubUrl"
    }

    Write-Do "$SiteUrl -> $HubUrl"

    Add-PnPHubSiteAssociation `
        -Site $SiteUrl `
        -HubSite $HubUrl | Out-Null
}
function Ensure-List {
    param(
        [Parameter(Mandatory = $true)]
        $ListDef
    )

    $title = $ListDef.Title
    $template = $ListDef.Template

    if ([string]::IsNullOrWhiteSpace($template)) {
        $template = "GenericList"
    }

    if (-not $Apply) {
        Write-Plan "Lista/biblioteka: $title [$template]"
        return
    }

    $existing = Get-PnPList -Identity $title -ErrorAction SilentlyContinue

    if ($existing) {
        Write-Host "Istnieje: $title" -ForegroundColor DarkYellow
        return
    }

    Write-Do "Tworzenie: $title [$template]"

    New-PnPList `
        -Title $title `
        -Template $template `
        -OnQuickLaunch | Out-Null

    if ($template -eq "DocumentLibrary" -and $ListDef.EnableVersioning -eq $true) {
        Set-PnPList `
            -Identity $title `
            -EnableVersioning $true | Out-Null
    }
}

function Ensure-SiteContent {
    param(
        [Parameter(Mandatory = $true)]
        $Site
    )

    Write-Step "Zawartość witryny: $($Site.Title)"

    if ($Site.Libraries) {
        foreach ($lib in @($Site.Libraries)) {
            Ensure-List -ListDef $lib
        }
    }

    if ($Site.Lists) {
        foreach ($list in @($Site.Lists)) {
            Ensure-List -ListDef $list
        }
    }
}

function Resolve-NavUrl {
    param(
        [Parameter(Mandatory = $true)]
        $Node,

        [Parameter(Mandatory = $true)]
        [hashtable]$SiteUrlByKey
    )

    $urlProperty = $Node.PSObject.Properties["Url"]
    $siteKeyProperty = $Node.PSObject.Properties["SiteKey"]

    if ($null -ne $urlProperty -and -not [string]::IsNullOrWhiteSpace([string]$urlProperty.Value)) {
        return [string]$urlProperty.Value
    }

    if ($null -ne $siteKeyProperty -and -not [string]::IsNullOrWhiteSpace([string]$siteKeyProperty.Value)) {
        $siteKey = [string]$siteKeyProperty.Value

        if ($SiteUrlByKey.ContainsKey($siteKey)) {
            return $SiteUrlByKey[$siteKey]
        }

        throw "Nie znaleziono SiteKey w mapie witryn: $siteKey"
    }

    throw "Element nawigacji '$($Node.Title)' musi mieć właściwość Url albo SiteKey."
}
function Ensure-HubNavigation {
    param(
        [Parameter(Mandatory = $true)]
        $Navigation,

        [Parameter(Mandatory = $true)]
        [hashtable]$SiteUrlByKey
    )

    Write-Step "Nawigacja portalu korporacyjnego"

    foreach ($node in @($Navigation.TopNavigation)) {
        $url = Resolve-NavUrl -Node $node -SiteUrlByKey $SiteUrlByKey

        if (-not $Apply) {
            Write-Plan "TopNavigationBar: $($node.Title) -> $url"
            continue
        }

        $existing = Get-PnPNavigationNode -Location TopNavigationBar |
            Where-Object { $_.Title -eq $node.Title } |
            Select-Object -First 1

        if ($existing) {
            Write-Host "Link już istnieje: $($node.Title)" -ForegroundColor DarkYellow
            continue
        }

        Write-Do "Dodanie linku: $($node.Title)"

        Add-PnPNavigationNode `
            -Location TopNavigationBar `
            -Title $node.Title `
            -Url $url | Out-Null
    }
}

function Ensure-PlaceholderPages {
    param(
        [Parameter(Mandatory = $true)]
        $Pages,

        [Parameter(Mandatory = $true)]
        [hashtable]$SiteUrlByKey
    )

    foreach ($page in @($Pages)) {
        $siteUrl = $SiteUrlByKey[$page.SiteKey]

        Write-Step "Strona placeholder: $($page.Title) [$siteUrl]"

        Connect-Spo -Url $siteUrl

        if (-not $Apply) {
            Write-Plan "Add-PnPPage -Name $($page.Name) -Title $($page.Title)"
            Write-Plan "Set-PnPPage -Identity $($page.Name) -Publish"
            continue
        }

        $existing = Get-PnPPage -Identity $page.Name -ErrorAction SilentlyContinue

        if ($existing) {
            Write-Host "Strona już istnieje: $($page.Name)" -ForegroundColor DarkYellow
        }
        else {
            Write-Do "Tworzenie strony: $($page.Name)"

            Add-PnPPage `
                -Name $page.Name `
                -Title $page.Title `
                -LayoutType Article | Out-Null
        }

        Write-Do "Publikacja strony: $($page.Name)"

        Set-PnPPage `
            -Identity $page.Name `
            -Publish | Out-Null
    }
}

function Main {
    Assert-PnPModule

    if (-not (Test-Path $ConfigPath)) {
        throw "Nie znaleziono konfiguracji: $ConfigPath"
    }

    $cfg = Get-Content `
        -Path $ConfigPath `
        -Raw `
        -Encoding UTF8 | ConvertFrom-Json

    Write-Host ""
    Write-Host "Corporate Portal Deployment — SharePoint Online" -ForegroundColor White
    Write-Host "Tryb: $(if ($Apply) { 'WYKONANIE' } else { 'DRY-RUN / PLAN' })" -ForegroundColor White

    $tenant = $cfg.Tenant

    # WAŻNE:
    # Nie używamy zmiennej $home, ponieważ PowerShell traktuje nazwy zmiennych
    # bez rozróżniania wielkości liter. $home koliduje z wbudowaną zmienną $HOME.
    $homeSite = $cfg.HomeSite

    $sites = @($cfg.Sites)
    $siteUrlByKey = @{}

    Connect-Spo -Url $tenant.AdminUrl

    $homeUrl = Ensure-ModernSite `
        -Tenant $tenant `
        -Site $homeSite

    $siteUrlByKey[$homeSite.Key] = $homeUrl

    if ($homeSite.RegisterAsHubSite -eq $true) {
        Register-HubSiteIfNeeded `
            -HubUrl $homeUrl `
            -Principals @($homeSite.AssociationRightsPrincipals)
    }

    foreach ($site in $sites) {
        $url = Ensure-ModernSite `
            -Tenant $tenant `
            -Site $site

        $siteUrlByKey[$site.Key] = $url

        Associate-ToHub `
            -SiteUrl $url `
            -HubUrl $homeUrl
    }

    foreach ($site in @($homeSite) + $sites) {
        $url = $siteUrlByKey[$site.Key]

        Connect-Spo -Url $url

        Ensure-SiteContent -Site $site
    }

    if ($cfg.PagesToCreateAsPlaceholders) {
        Ensure-PlaceholderPages `
            -Pages @($cfg.PagesToCreateAsPlaceholders) `
            -SiteUrlByKey $siteUrlByKey
    }

    Connect-Spo -Url $homeUrl

    Ensure-HubNavigation `
        -Navigation $cfg.Navigation `
        -SiteUrlByKey $siteUrlByKey

    Connect-Spo -Url $tenant.AdminUrl

    if ($homeSite.SetAsHomeSite -eq $true) {
        Set-HomeSiteIfNeeded `
            -HomeSiteUrl $homeUrl `
            -VivaConnectionsDefaultStart ([bool]$homeSite.VivaConnectionsDefaultStart)
    }

    Write-Host ""
    Write-Host "Zakończono." -ForegroundColor Green

    if (-not $Apply) {
        Write-Host "To był tryb planu. Aby wykonać zmiany, dodaj parametr -Apply." -ForegroundColor Yellow
    }
}

Main