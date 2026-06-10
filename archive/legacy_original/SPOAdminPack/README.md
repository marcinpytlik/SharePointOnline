# SPOAdminPack

Pakiet skryptów PowerShell do administracji **SharePoint Online** i **OneDrive for Business**.

Autor roboczy: marcin / SQLManiak style  
Zakres: audyt, raporty, kopie techniczne plików, udostępnienia, storage, kosz, site admins.

> Ważne: skrypty backupowe w tym pakiecie wykonują **techniczną kopię plików**, a nie pełny backup Microsoft 365. Nie zastępują dedykowanego systemu backupowego M365.

---

## Struktura

```text
SPOAdminPack
├── config
│   ├── sites.txt
│   ├── onedrive_urls.txt
│   └── settings.json
├── scripts
│   ├── 00_Install-RequiredModules.ps1
│   ├── 01_Report-TenantSites.ps1
│   ├── 02_Report-ExternalSharing.ps1
│   ├── 03_Report-Libraries.ps1
│   ├── 04_Report-OldFiles.ps1
│   ├── 05_Report-FolderStorage.ps1
│   ├── 06_Report-SharingLinksWithoutExpiration.ps1
│   ├── 07_Report-LibrariesWithoutVersioning.ps1
│   ├── 08_Report-RecycleBin.ps1
│   ├── 09_Report-SiteAdmins.ps1
│   ├── 10_Report-OneDriveUsageGraph.ps1
│   ├── 11_Backup-SPO-SiteFiles.ps1
│   ├── 12_Backup-OneDrive-Files.ps1
│   └── 13_Report-SPO-OneDrive-Sharing.ps1
├── output
└── docs
```

---

## Instalacja modułów

Uruchom PowerShell jako użytkownik administracyjny albo zwykły użytkownik z prawem instalacji modułów w `CurrentUser`.

```powershell
cd .\SPOAdminPack
.\scripts\00_Install-RequiredModules.ps1
```

Wymagane moduły:

- `PnP.PowerShell`
- `Microsoft.Graph.Reports`

---

## Konfiguracja

Uzupełnij:

```text
config\sites.txt
config\onedrive_urls.txt
config\settings.json
```

Przykład `sites.txt`:

```text
https://tenant.sharepoint.com/sites/IT
https://tenant.sharepoint.com/sites/HR
```

Przykład `onedrive_urls.txt`:

```text
https://tenant-my.sharepoint.com/personal/jan_kowalski_contoso_com
```

---

## Najczęstsze uruchomienia

### 1. Raport wszystkich witryn tenantowych

```powershell
.\scripts\01_Report-TenantSites.ps1 `
  -TenantAdminUrl "https://tenant-admin.sharepoint.com" `
  -OutputRoot "D:\M365Reports"
```

### 2. Raport witryn z external sharing

```powershell
.\scripts\02_Report-ExternalSharing.ps1 `
  -TenantAdminUrl "https://tenant-admin.sharepoint.com" `
  -OutputRoot "D:\M365Reports"
```

### 3. Raport bibliotek dokumentów

```powershell
.\scripts\03_Report-Libraries.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -OutputRoot "D:\M365Reports"
```

### 4. Raport starych plików

```powershell
.\scripts\04_Report-OldFiles.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -Libraries "Documents","Shared Documents" `
  -OlderThanMonths 12 `
  -OutputRoot "D:\M365Reports"
```

### 5. Raport storage folderów

```powershell
.\scripts\05_Report-FolderStorage.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -FolderSiteRelativeUrls "Shared Documents","Documents" `
  -OutputRoot "D:\M365Reports"
```

### 6. Linki udostępniania bez daty wygaśnięcia

```powershell
.\scripts\06_Report-SharingLinksWithoutExpiration.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -FolderSiteRelativeUrls "Shared Documents","Documents" `
  -OutputRoot "D:\M365Reports"
```

### 7. Biblioteki bez wersjonowania

```powershell
.\scripts\07_Report-LibrariesWithoutVersioning.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -OutputRoot "D:\M365Reports"
```

### 8. Kosz SharePoint Online

```powershell
.\scripts\08_Report-RecycleBin.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -OutputRoot "D:\M365Reports"
```

### 9. Site collection admins

```powershell
.\scripts\09_Report-SiteAdmins.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -OutputRoot "D:\M365Reports"
```

### 10. OneDrive usage z Microsoft Graph

```powershell
.\scripts\10_Report-OneDriveUsageGraph.ps1 `
  -Period D30 `
  -OutputRoot "D:\M365Reports"
```

### 11. Techniczna kopia plików z SharePoint Online

```powershell
.\scripts\11_Backup-SPO-SiteFiles.ps1 `
  -SiteUrl "https://tenant.sharepoint.com/sites/IT" `
  -BackupRoot "D:\SPOBackups" `
  -AllDocumentLibraries
```

### 12. Techniczna kopia plików z OneDrive

```powershell
.\scripts\12_Backup-OneDrive-Files.ps1 `
  -OneDriveUrl "https://tenant-my.sharepoint.com/personal/jan_kowalski_contoso_com" `
  -BackupRoot "D:\OneDriveBackups"
```

### 13. Raport udostępnień SharePoint Online + OneDrive

```powershell
.\scripts\13_Report-SPO-OneDrive-Sharing.ps1 `
  -UrlsFile ".\config\sites.txt" `
  -OutputRoot "D:\M365SharingReports" `
  -AllDocumentLibraries
```

Dla OneDrive:

```powershell
.\scripts\13_Report-SPO-OneDrive-Sharing.ps1 `
  -UrlsFile ".\config\onedrive_urls.txt" `
  -OutputRoot "D:\M365SharingReports" `
  -AllDocumentLibraries
```

---

## Uwagi bezpieczeństwa

1. Nie uruchamiaj skryptów na produkcji bez testu na jednej witrynie.
2. Najpierw uruchamiaj raporty, dopiero później skrypty porządkowe.
3. Ten pakiet nie usuwa danych ani nie zmienia konfiguracji witryn.
4. Backup SPO/OneDrive w tym pakiecie to kopia plików, nie pełny backup M365.
5. Wyniki CSV mogą zawierać dane osobowe i adresy URL do zasobów, więc przechowuj je bezpiecznie.

---

## Proponowany workflow administracyjny

1. `01_Report-TenantSites.ps1`
2. `02_Report-ExternalSharing.ps1`
3. `13_Report-SPO-OneDrive-Sharing.ps1`
4. `07_Report-LibrariesWithoutVersioning.ps1`
5. `04_Report-OldFiles.ps1`
6. `05_Report-FolderStorage.ps1`
7. `09_Report-SiteAdmins.ps1`

