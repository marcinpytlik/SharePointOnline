# Porządkowanie repo – notatka

## Zachowane pakiety źródłowe

- `archive/legacy_original/SPOAdminPack` – nowy pakiet wygenerowany w rozmowie.
- `archive/legacy_original/SPO_Admin_Pack` – starszy pakiet SharePoint Online.
- `archive/legacy_original/Teams_Admin_Pack` – starszy pakiet Teams, zostawiony jako opcjonalny.

## Decyzje

1. Nie dołączałem katalogu `.git` ze starego ZIP-a.
2. Nie usuwałem żadnego wartościowego skryptu — duplikaty i starsze warianty trafiły do `archive` albo katalogów `legacy/archive`.
3. Skrypty Teams są oddzielone, bo repo nazywa się SharePointOnline, ale Teams też był w paczce.
4. Cleanup dostał poprawioną wersję główną: `scripts/05_storage_cleanup/02_Cleanup-SpoLibraries.ps1`.

## Najważniejsze pliki do codziennego użycia

- `scripts/01_inventory/01_Report-TenantSites.ps1`
- `scripts/02_security_sharing/13_Report-SPO-OneDrive-Sharing.ps1`
- `scripts/04_backup_export/01_Backup-SPO-SiteFiles.ps1`
- `scripts/04_backup_export/02_Backup-OneDrive-Files.ps1`
- `scripts/05_storage_cleanup/01_Report-OldFiles.ps1`
- `scripts/05_storage_cleanup/02_Cleanup-SpoLibraries.ps1`
- `scripts/06_governance/01_Report-LibrariesWithoutVersioning.ps1`
