# SharePoint Online – Admin Pack (SPO)

Pakiet materiałów administracyjnych dla SharePoint Online (SPO) + OneDrive + warstwa compliance/audyt (Purview/Unified Audit Log) oraz zestaw skryptów PowerShell pod Windows.

## Zawartość
- `docs/SPO_Admin_Module.md` – duży moduł szkoleniowo-operacyjny (admin).
- `docs/checklists/` – checklisty wdrożeniowe i operacyjne.
- `docs/labs/` – krótkie laby do ćwiczeń.
- `scripts/` – gotowe skrypty PowerShell:
  - SPO Management Shell (`Microsoft.Online.SharePoint.PowerShell`)
  - PnP.PowerShell
  - (opcjonalnie) Unified Audit Log (wymaga Exchange Online Management)

## Wymagania
- Windows 10/11/Server + PowerShell 7 (zalecane) lub Windows PowerShell 5.1
- Uprawnienia: SharePoint Administrator / Global Administrator (część akcji)
- Dostęp do internetu (instalacja modułów)

## Szybki start
1. Zainstaluj moduły:
   ```powershell
   .\scripts\Install-Modules.ps1
   ```
2. Uzupełnij `scripts\settings.example.json` i zapisz jako `scripts\settings.json`.
3. Uruchom raport governance:
   ```powershell
   .\scripts\Get-SPOGovernanceReport.ps1 -SettingsPath .\scripts\settings.json
   ```

## Bezpieczeństwo
Skrypty raportujące są „read-only”. Skrypty zmieniające ustawienia mają przełącznik `-WhatIf` i/lub wymagają potwierdzenia.

## Licencja
Materiały: CC BY 4.0 (autor: marcin). Skrypty: do użycia wewnętrznie / edukacyjnie.
