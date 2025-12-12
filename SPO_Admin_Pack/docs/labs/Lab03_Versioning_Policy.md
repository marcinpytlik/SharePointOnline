# Lab 03 – Ograniczenie wersjonowania w bibliotekach (PnP)

## Cel
Ograniczysz liczbę wersji (np. do 200) w bibliotekach dokumentów.

## Kroki
1. Najpierw symulacja:
```powershell
.\scripts\Set-PnPDocumentLibrariesVersioning.ps1 -SiteUrl "https://TENANT.sharepoint.com/sites/ProjektX" -MaxVersions 200 -WhatIf
```

2. Wykonanie:
```powershell
.\scripts\Set-PnPDocumentLibrariesVersioning.ps1 -SiteUrl "https://TENANT.sharepoint.com/sites/ProjektX" -MaxVersions 200 -Confirm
```

## Uwaga
Nie rób tego „w ciemno” w całym tenancie – najpierw ustal politykę i komunikację z ownerami.
