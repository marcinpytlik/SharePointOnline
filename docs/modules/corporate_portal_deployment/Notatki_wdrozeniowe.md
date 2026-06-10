# Notatki wdrożeniowe — Portal korporacyjny SharePoint Online

## Model informacyjny

```text
Home Site
│
├── Global Navigation / SharePoint App Bar
│
├── Hub Site: Portal korporacyjny
│   ├── Site: Aktualności
│   ├── Site: HR
│   ├── Site: IT
│   ├── Site: Finanse
│   ├── Site: Dokumenty firmowe
│   ├── Site: Baza wiedzy
│   └── Site: Projekty
│
└── Term Store
    ├── Departments
    ├── Document Types
    ├── Business Processes
    ├── Systems
    ├── Locations
    ├── Confidentiality Levels
    ├── Document Statuses
    ├── Audiences
    └── Knowledge Areas
```

## Menu główne

```text
Start
Aktualności
Firma
Działy
Dokumenty
Procesy
Systemy
HR
IT
Finanse
Projekty
Baza wiedzy
Kontakt
```

## Rekomendacja wdrożeniowa

Najpierw wdrożyć szkielet:

1. Home Site.
2. Hub Site.
3. Witryny powiązane.
4. Nawigacja.
5. Term Store.

Dopiero potem:

1. kolumny metadanych,
2. typy zawartości,
3. retencja,
4. etykiety poufności,
5. targetowanie odbiorców,
6. gotowe strony główne działów.
# Przygotowania

Install-Module Microsoft.Graph -Scope CurrentUser -AllowClobber
Install-Module PnP.PowerShell -Scope CurrentUser -AllowClobber
Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -AllowClobber
# tenantid
Connect-MgGraph -Scopes "Organization.Read.All"
alternatywnie logowanie 
Connect-MgGraph -Scopes "Organization.Read.All" -UseDeviceAuthentication

Get-MgOrganization | Select-Object Id, DisplayName
Get-MgOrganization |
    Select-Object -ExpandProperty VerifiedDomains |
    Select-Object Name, IsInitial, IsDefault
# sharepoint admin
$tenantShortName = "sqlmaniak"

$spoAdminUrl = "https://$tenantShortName-admin.sharepoint.com"

Connect-SPOService -Url $spoAdminUrl

Get-SPOTenant | Select-Object RootSiteUrl
# utworzenie clientid
    Register-PnPEntraIDAppForInteractiveLogin `
  -ApplicationName "PnP PowerShell - Corporate Portal Deployment" `
  -Tenant "576gdp.onmicrosoft.com" `
  -Interactive
  #tenantid=6e335731-2cd1-41ea-9a0f-8054c7fc3b9e
  #clientid 4e167d14-d4d0-484a-87f8-c3745bf38ef4
