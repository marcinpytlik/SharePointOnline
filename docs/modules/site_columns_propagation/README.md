# Site Columns Propagation

Moduł służy do dodawania site columns z witryny głównej SharePoint Online do bibliotek dokumentów w podwitrynach.

## Skrypt

`scripts/09_site_columns_propagation/Add-RootSiteColumns-To-SubsitesLibraries.ps1`

## Zastosowanie

Skrypt jest przeznaczony dla klasycznej struktury SharePoint Online:

```text
Root site
├── Subsite 1
├── Subsite 2
└── Subsite 3
.\scripts\09_site_columns_propagation\Add-RootSiteColumns-To-SubsitesLibraries.ps1 `
    -RootSiteUrl "https://tenant.sharepoint.com/sites/Intranet" `
    -ColumnInternalNames "SQLM_Dzial","SQLM_TypDokumentu","SQLM_DataObowiazywania" `
    -AllDocumentLibraries `
    -OutputRoot "D:\SPOReports"
Uwagi
Skrypt dodaje wskazane site columns do bibliotek w podwitrynach.
Nie tworzy automatycznie content types.
Dla Managed Metadata / Term Store należy zachować ostrożność i testować najpierw na jednej bibliotece.
Zalecany model docelowy: site columns + content types.