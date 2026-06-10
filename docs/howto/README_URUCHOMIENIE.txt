SPOAdminPack - szybki start

1. Otworz PowerShell.
2. Przejdz do folderu SPOAdminPack.
3. Uruchom:

   .\scripts\00_Install-RequiredModules.ps1

4. Uzupełnij:

   .\config\sites.txt
   .\config\onedrive_urls.txt

5. Pierwszy test:

   .\scripts\03_Report-Libraries.ps1 -UrlsFile ".\config\sites.txt" -OutputRoot "D:\M365Reports"

6. Raport udostepnien:

   .\scripts\13_Report-SPO-OneDrive-Sharing.ps1 -UrlsFile ".\config\sites.txt" -OutputRoot "D:\M365SharingReports" -AllDocumentLibraries

7. Kopia plikow SharePoint Online:

   .\scripts\11_Backup-SPO-SiteFiles.ps1 -SiteUrl "https://tenant.sharepoint.com/sites/IT" -BackupRoot "D:\SPOBackups" -AllDocumentLibraries

8. Kopia plikow OneDrive:

   .\scripts\12_Backup-OneDrive-Files.ps1 -OneDriveUrl "https://tenant-my.sharepoint.com/personal/jan_kowalski_contoso_com" -BackupRoot "D:\OneDriveBackups"
