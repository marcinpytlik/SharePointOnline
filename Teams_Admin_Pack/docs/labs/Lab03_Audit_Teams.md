# Lab 03 – Audyt Teams (Unified Audit Log)

## Wymagania
- ExchangeOnlineManagement
- uprawnienia do audytu

## Kroki
1. Instalacja:
```powershell
.\scripts\Install-Modules.ps1 -IncludeExchangeOnline
```

2. Pobranie audytu z 7 dni:
```powershell
.\scripts\Get-UnifiedAuditLog_Teams.ps1 -LookbackDays 7 -OutputPath .\scripts\reports
```

## Wariant: większy zestaw wyników
```powershell
.\scripts\Get-UnifiedAuditLog_Teams.ps1 -LookbackDays 7 -OutputPath .\scripts\reports -UseReturnLargeSet -SessionId "TeamsAuditSearch"
```
