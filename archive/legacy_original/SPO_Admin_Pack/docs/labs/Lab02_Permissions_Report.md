# Lab 02 – Raport uprawnień site’a (PnP)

## Cel
Zobaczysz:
- site collection admins
- grupy i członków
- biblioteki/listy z unikalnymi uprawnieniami

## Kroki
1. Uruchom:
```powershell
.\scripts\Get-PnPSitePermissionsReport.ps1 -SiteUrl "https://TENANT.sharepoint.com/sites/ProjektX" -OutputPath .\scripts\reports
```

2. Przejrzyj CSV:
- `*_SiteCollectionAdmins.csv`
- `*_GroupsMembers.csv`
- `*_Lists_UniquePermissions.csv`

## Bonus
Uruchom z `-IncludeItemLevel` (uważaj na czas):
```powershell
.\scripts\Get-PnPSitePermissionsReport.ps1 -SiteUrl "..." -OutputPath .\scripts\reports -IncludeItemLevel
```
