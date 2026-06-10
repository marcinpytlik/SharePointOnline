# Wdrożenie Home Site, Hub Site, Global Navigation i Term Store — SharePoint Online

## Cel 

Paczka przygotowuje wdrożenie struktury:

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

## Zawartość paczki

```text
sharepoint_corporate_portal_deployment
├── config
│   ├── corporate-portal.structure.json
│   └── corporate-termstore.json
├── docs
│   ├── README.md
│   └── Notatki_wdrozeniowe.md
└── scripts
    ├── Deploy-CorporatePortal.ps1
    └── Deploy-CorporateTermStore.ps1
```

## Co wdraża skrypt portalu?

Skrypt `Deploy-CorporatePortal.ps1`:

1. Tworzy witrynę komunikacyjną `Portal korporacyjny`.
2. Rejestruje ją jako `Hub Site`.
3. Tworzy witryny: Aktualności, HR, IT, Finanse, Dokumenty firmowe, Baza wiedzy, Projekty.
4. Kojarzy witryny z hubem.
5. Tworzy podstawowe biblioteki i listy.
6. Tworzy strony placeholder: Firma, Działy, Procesy.
7. Dodaje główną nawigację.
8. Ustawia Portal korporacyjny jako Home Site.

## Co wdraża skrypt Term Store?

Skrypt `Deploy-CorporateTermStore.ps1` tworzy:

- Term Group: `Corporate Portal`,
- Term Sety: Departments, Document Types, Business Processes, Systems, Locations, Confidentiality Levels, Document Statuses, Audiences, Knowledge Areas.

## Wymagania

Uruchamiaj w PowerShell 7 na Windows.

```powershell
Install-Module PnP.PowerShell -Scope CurrentUser -AllowClobber
```

Do skryptu portalu potrzebujesz uprawnień SharePoint Administrator lub Global Administrator.

Do skryptu Term Store konto musi mieć uprawnienia do zarządzania Term Store.

## Krok 1. Dostosuj tenant

Otwórz:

```text
config\corporate-portal.structure.json
```

Zmień:

```text
https://twojtenant.sharepoint.com
https://twojtenant-admin.sharepoint.com
```

na adresy Twojego tenant Microsoft 365.

Zmień również:

```text
sharepoint-admin@twojtenant.onmicrosoft.com
```

na realne konto lub grupę administratorów SharePoint.

## Krok 2. Tryb planu — portal

Najpierw uruchom bez parametru `-Apply`:

```powershell
cd .\sharepoint_corporate_portal_deployment

.\scripts\Deploy-CorporatePortal.ps1 `
  -ConfigPath .\config\corporate-portal.structure.json
```

Ten tryb niczego nie tworzy. Pokazuje tylko plan.

## Krok 3. Wdrożenie portalu

Po sprawdzeniu planu:

```powershell
.\scripts\Deploy-CorporatePortal.ps1 `
  -ConfigPath .\config\corporate-portal.structure.json `
  -ClientId "TWOJ-CLIENT-ID" `
  -Apply
```

## Krok 4. Tryb planu — Term Store

```powershell
.\scripts\Deploy-CorporateTermStore.ps1 `
  -ConfigPath .\config\corporate-termstore.json `
  -AdminUrl "https://twojtenant-admin.sharepoint.com"
```

## Krok 5. Wdrożenie Term Store

```powershell
.\scripts\Deploy-CorporateTermStore.ps1 `
  -ConfigPath .\config\corporate-termstore.json `
  -AdminUrl "https://twojtenant-admin.sharepoint.com" `
  -ClientId "TWOJ-CLIENT-ID" `
  -Apply
```

## Ważne: Global Navigation / SharePoint App Bar

Skrypt ustawia witrynę jako Home Site i przygotowuje nawigację huba.

Global Navigation w SharePoint App Bar zwykle należy włączyć z poziomu Home Site:

```text
Home Site
→ Settings
→ Global navigation
→ Enable global navigation
→ Source: Hub or global navigation
→ Save
```

## Kolejność wdrożenia rekomendowana

1. Uzupełnij konfigurację JSON.
2. Uruchom dry-run portalu.
3. Wdróż portal.
4. Sprawdź, czy hub i witryny powiązane działają.
5. Ustaw Global Navigation w Home Site.
6. Uruchom dry-run Term Store.
7. Wdróż Term Store.
8. Dopiero potem podpinaj kolumny metadanych do bibliotek dokumentów.

## Czego paczka celowo nie robi?

Ta paczka nie ustawia jeszcze:

- etykiet poufności Microsoft Purview,
- retencji,
- kolumn Managed Metadata w bibliotekach,
- targetowania odbiorców w nawigacji,
- pełnej treści stron głównych,
- uprawnień szczegółowych dla każdego działu.
