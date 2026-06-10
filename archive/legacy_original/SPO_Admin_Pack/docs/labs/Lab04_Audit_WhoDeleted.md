# Lab 04 – Audyt: kto usunął plik? (Unified Audit Log)

## Cel
Pobierzesz zdarzenia audytu dla operacji usuwania/przenoszenia/udostępniania.

## Wymagania
- moduł `ExchangeOnlineManagement`
- uprawnienia do audytu

## Kroki
1. Instalacja:
```powershell
.\scripts\Install-Modules.ps1 -IncludeExchangeOnline
```

2. Pobranie logów z ostatnich 7 dni:
```powershell
.\scripts\Get-UnifiedAuditLog_SharePoint.ps1 -LookbackDays 7 -OutputPath .\scripts\reports
```

3. Otwórz CSV i filtruj po `SiteUrl`, `SourceFile`, `Operation`.
