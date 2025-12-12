# Lab 01 – Governance report tenant’a (Teams PowerShell)

## Cel
Wygenerujesz raport Teamów, ownerów i kanałów.

## Kroki
1. Instalacja:
```powershell
.\scripts\Install-Modules.ps1
```

2. Ustawienia:
- `scripts/settings.example.json` → `scripts/settings.json`

3. Raport:
```powershell
.\scripts\Get-TeamsGovernanceReport.ps1 -SettingsPath .\scripts\settings.json
```

4. Wyniki: `scripts/reports/`
