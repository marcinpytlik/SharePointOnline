# Microsoft Teams – Admin Pack

Pakiet materiałów administracyjnych dla Microsoft Teams: governance, bezpieczeństwo, polityki, audyt, troubleshooting + zestaw skryptów PowerShell pod Windows.

## Zawartość
- `docs/Teams_Admin_Module.md` – duży moduł szkoleniowo-operacyjny (admin).
- `docs/checklists/` – checklisty wdrożeniowe i operacyjne.
- `docs/labs/` – krótkie laby do ćwiczeń.
- `scripts/` – gotowe skrypty PowerShell:
  - MicrosoftTeams PowerShell module
  - (opcjonalnie) Unified Audit Log przez ExchangeOnlineManagement

## Wymagania
- Windows PowerShell 5.1 lub PowerShell 7 (w razie problemów z Teams PS – przełącz na 5.1)
- Uprawnienia: Teams Administrator / Global Administrator (zależnie od akcji)
- Dostęp do internetu (instalacja modułów)

## Szybki start
1. Zainstaluj moduły:
```powershell
.\scripts\Install-Modules.ps1
```

2. Uzupełnij `scripts\settings.example.json` i zapisz jako `scripts\settings.json`.

3. Uruchom raport governance:
```powershell
.\scripts\Get-TeamsGovernanceReport.ps1 -SettingsPath .\scripts\settings.json
```

## Licencja
Materiały: CC BY 4.0 (autor: marcin). Skrypty: do użycia wewnętrznie / edukacyjnie.
