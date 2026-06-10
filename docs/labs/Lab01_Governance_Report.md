# Lab 01 – Governance report tenant’a (SPO Management Shell)

## Cel
Wygenerujesz raport site’ów (CSV + Markdown) i zidentyfikujesz:
- top site’y po storage
- rozkład SharingCapability
- rozkład template’ów

## Kroki
1. Zainstaluj moduły:
```powershell
.\scripts\Install-Modules.ps1
```

2. Skopiuj ustawienia:
- `scripts/settings.example.json` → `scripts/settings.json`
- uzupełnij `TenantAdminUrl`

3. Uruchom raport:
```powershell
.\scripts\Get-SPOGovernanceReport.ps1 -SettingsPath .\scripts\settings.json
```

4. Otwórz wyniki w `scripts/reports/`.
