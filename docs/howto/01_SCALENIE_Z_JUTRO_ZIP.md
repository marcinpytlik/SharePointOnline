# Jak wgrać scaloną paczkę do jednego repo

1. Rozpakuj ZIP.
2. Skopiuj zawartość katalogu `SharePointOnline` do lokalnego repo:

```powershell
C:\Users\blad\Documents\GitHub\SharePointOnline
```

3. W repo wykonaj:

```powershell
git status
git add .
git commit -m "Merge SPO training and corporate portal files"
git push
```

Jeżeli lokalne repo ma być źródłem prawdy i chcesz nadpisać GitHuba:

```powershell
git push --force origin main
```

## Co zostało pominięte z Jutro.zip?

- `sharepoint_corporate_portal_deployment/.git` — stare osobne repo.
- `sharepoint_corporate_portal_deployment/.psmodules` — lokalnie pobrany moduł PnP.PowerShell, nie powinien być trzymany w repo.
- `desktop.ini` — śmieci systemowe Windows.
