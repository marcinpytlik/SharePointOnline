---
title: "SharePoint Online – Administracja (Moduł)"
author: "marcin"
date: "2025-12-12"
license: "CC BY 4.0"
---

# SharePoint Online – administracja (moduł duży)

Ten materiał jest napisany dla osoby, która **administrowała już systemami**, ale chce mieć spójny, praktyczny „operacyjny model” dla SharePoint Online (SPO) + OneDrive + warstwa compliance (Purview/Audit).

**Cel:** po przerobieniu modułu potrafisz:
- skonfigurować podstawowe polityki bezpieczeństwa (sharing, goście, dostęp),
- zarządzać cyklem życia site’ów,
- diagnozować incydenty („kto udostępnił?”, „kto usunął?”, „czemu nie ma dostępu?”),
- przygotować governance (nazewnictwo, właściciele, provisioning),
- uruchomić raporty (SPO shell + PnP + Unified Audit Log).

> Uwaga: SharePoint Online jest „organiczny” – część sterowania siedzi w SharePoint Admin Center, część w Entra, a compliance w Purview. Admin musi lubić mapy.

---

## 0. Warstwy administracji (mentalny model)

### 0.1 Co jest „SharePointem”, a co go otacza
- **SharePoint Online (SPO)** – serwis przechowujący i serwujący treści (site’y, biblioteki, listy, strony).
- **OneDrive for Business** – osobiste site’y użytkowników (w praktyce: też SPO).
- **Microsoft 365 Groups** – tożsamość grupowa (właściciele, członkowie), która „spina” Teams, SharePoint, Planner itd.
- **Entra ID (Azure AD)** – tożsamości, grupy, MFA, Conditional Access, aplikacje.
- **Microsoft Purview** – audyt, retencja, eDiscovery, DLP, sensitivity labels.

### 0.2 Zasada operacyjna
Jeżeli coś „dziwnie działa”, to prawie zawsze jest to jedna z 4 kategorii:
1) **Uprawnienia** (grupy / dziedziczenie / unikalne perms),
2) **Polityki** (sharing, CA, DLP, sensitivity labels),
3) **Linki** (anonimowe vs dla konkretnych osób, wygasłe, ograniczone),
4) **Klient** (OneDrive sync, Office desktop, cache, przeglądarka).

---

## 1. SharePoint Admin Center – najważniejsze obszary

### 1.1 Active sites
Co tu robisz jako admin:
- przegląd i zarządzanie site’ami (właściciele, polityki, storage),
- nadawanie administratorów kolekcji,
- blokowanie site’a (Lock state),
- zmiana ustawień sharing per-site.

**Praktyka:**  
Najczęściej w incydencie zaczynasz od site’a: „Czy to właściwy site? Kto jest ownerem? Jakie ma polityki sharing?”

### 1.2 Policies: Sharing, Access control, OneDrive
W SPO kluczowe są:
- **Sharing** (external, anonymous, link types),
- **Access control** (np. ograniczenia pobierania, urządzenia niezarządzane),
- **OneDrive** (limity, udostępnianie, retencja).

### 1.3 Migration i Settings
- Migracje (w zależności od narzędzi i procesu).
- Globalne ustawienia tenant’a: baseline.

---

## 2. Governance: jak nie utonąć w „site sprawl”

### 2.1 Problem, który zawsze wraca
Bez governance dzieje się to:
- ludzie tworzą setki site’ów,
- każdy ma inne uprawnienia,
- nikt nie wie kto jest ownerem,
- storage rośnie przez wersje,
- goście zostają na zawsze.

**To nie jest wina użytkowników.** To normalny efekt braku zasad.

### 2.2 Minimum governance (do wprowadzenia „od jutra”)
- Konwencja nazw (np. `DEP-<dzial>-<projekt>`),
- Każdy site ma **min. 2 właścicieli**,
- „Kto może tworzyć” (M365 Groups) – ograniczyć lub ucywilizować,
- Proces: request → approval → provisioning,
- Okresowy przegląd: ownerzy + goście + sharing + storage.

### 2.3 Lifecycle (prosty)
- **Create** → **Operate** → **Review** → **Archive/Close** → **Delete/Retain**
- W praktyce: raz w miesiącu/kwartał raport + mail do ownerów.

---

## 3. Uprawnienia: model, który nie robi „permission spaghetti”

### 3.1 Zasada 80/20
- 80% przypadków: dostęp na poziomie site’a i biblioteki.
- 20% przypadków: unikalne perms na folderze/item – i to właśnie robi bałagan.

**Rekomendacja admina:**  
> Dostęp nadajemy przez **grupy**, nie osoby. Item-level perms traktujemy jak wyjątek, który trzeba raportować.

### 3.2 Typowe mechanizmy
- SharePoint Groups (Owners/Members/Visitors),
- M365 Group (Owners/Members),
- Entra Security Groups,
- Linki udostępnienia (czasem ważniejsze niż perms).

### 3.3 Diagnostyka: „czemu użytkownik nie ma dostępu?”
Check:
1) Czy jest w grupie? (a nie „miał być”)
2) Czy perms nie są złamane na bibliotece/folderze?
3) Czy link jest właściwego typu i nie wygasł?
4) Czy polityki (CA/DLP/Labels) nie blokują?

---

## 4. External sharing: polityka, która uratuje Ci weekend

### 4.1 Poziomy sharing (intuicyjnie)
Od najbezpieczniejszego do najbardziej ryzykownego:
- Disabled
- Existing guests only
- New and existing guests
- Anyone (anonymous links)

**Najczęstsza pułapka:**  
Tenant ma ustawione „Anyone”, bo ktoś kiedyś potrzebował, a potem zapomniano. I tak powstaje „permanentny link do świata”.

### 4.2 Podejście praktyczne
- Tenant: ustaw maksymalny poziom rozsądnie.
- Per-site: dopasuj do wrażliwości danych.
- Dla site’ów z danymi wrażliwymi: ogranicz sharing i rozważ dodatkowe kontrole (urządzenia zarządzane).

---

## 5. Storage i wersjonowanie: cichy zabójca budżetu

### 5.1 Dlaczego storage rośnie „sam”
- wersjonowanie (setki wersji),
- duże pliki (PPTX/MP4) edytowane często,
- kosz (recycle bin),
- kopiowanie/duplikaty.

### 5.2 Polityka wersji – zdrowy kompromis
- Włącz wersjonowanie, ale ustaw limit (np. 100–500).
- Dla bibliotek „roboczych” czasem 50–100 wystarcza.
- Dla dokumentów formalnych (umowy/procedury) – więcej, ale z kontrolą.

W pakiecie masz skrypt:
- `scripts/Set-PnPDocumentLibrariesVersioning.ps1` (z `-WhatIf`)

---

## 6. Audyt i dochodzenie: kto zrobił co i kiedy

### 6.1 Co jest źródłem prawdy
- **Purview Audit / Unified Audit Log** – logi działań.
- Historia wersji dokumentu – „co się zmieniło”.
- Informacje o sharing w bibliotece / detale linków.

### 6.2 Trzy klasy incydentów
1) **Utrata danych:** usunięcie / przeniesienie / nadpisanie  
2) **Wyciek:** udostępnienie zewnętrzne / link anonimowy  
3) **Nadużycie uprawnień:** ktoś zyskał dostęp „za szeroko”

### 6.3 Minimalny playbook incydentu „zniknął plik”
1) Sprawdź kosz (site recycle bin + second-stage).
2) Sprawdź historię wersji.
3) Sprawdź audyt: FileDeleted / FileMoved / FileRenamed.
4) Zweryfikuj perms: czy ktoś nie „odciął” dostępu.

W pakiecie masz skrypt:
- `scripts/Get-UnifiedAuditLog_SharePoint.ps1` (CSV)

---

## 7. OneDrive operacyjnie (offboarding i przejęcia)

OneDrive to „site użytkownika”. Najczęstsze sprawy admina:
- odejście pracownika: zabezpieczenie danych, przekazanie managerowi,
- udostępnienia „na zewnątrz” z OneDrive,
- problemy synchronizacji.

**Dobra praktyka:**  
Offboarding ma checklistę (w tym pakiecie).

---

## 8. Automatyzacja i raporty (PowerShell)

### 8.1 Dwa światy narzędzi
- **SPO Management Shell** – idealny do listy site’ów, ustawień tenant/per-site, storage.
- **PnP.PowerShell** – idealny do „wnętrza” site’a: listy, biblioteki, uprawnienia.

### 8.2 Raport governance (SPO)
Skrypt:
- `scripts/Get-SPOGovernanceReport.ps1`  
Wynik:
- `SPO_Sites_Governance.csv`
- `SPO_Governance_Summary.md`

### 8.3 Raport uprawnień (PnP)
Skrypt:
- `scripts/Get-PnPSitePermissionsReport.ps1`  
Wynik:
- admins, grupy+członkowie, biblioteki z unikalnymi perms.

---

## 9. Standardy operacyjne (SOP) – gotowy zestaw zasad

### 9.1 Standard „site provisioning”
- Owner 1 + Owner 2 (obowiązkowo)
- Template (Team site / Communication site)
- Sharing policy per-site
- Domyślne biblioteki: wersjonowanie + limity
- Wstępne grupy: Owners/Members/Visitors (lub M365)

### 9.2 Standard „guest management”
- Goście tylko przez sponsorów (owner),
- Przegląd co miesiąc/kwartał,
- Usuwanie nieaktywnych gości.

### 9.3 Standard „incident response”
- Zgłoszenie → identyfikacja site + obiektu → audyt → przywrócenie → poprawa polityki

---

## 10. Laby (krótkie ćwiczenia)

W folderze `docs/labs/` masz krótkie scenariusze:
- Lab 01: Raport governance tenant’a
- Lab 02: Diagnoza uprawnień na site
- Lab 03: Ograniczenie wersjonowania w bibliotekach
- Lab 04: Unified Audit Log – „kto usunął plik?”

---

## 11. Dodatkowe notatki admina (praktyczne tipy)

- Teams kanał = folder w bibliotece dokumentów powiązanego site’a.
- „Nie mam dostępu” często oznacza: *mam link, ale nie mam perms* albo odwrotnie.
- Anonymous links: krótkoterminowe, z wygasaniem, najlepiej wyłączone wrażliwym site’om.
- Item-level perms: raportować i sprzątać, bo psują zarządzalność.

---

## 12. Appendix: komendy szybkiego startu

### 12.1 Instalacja modułów
```powershell
.\scripts\Install-Modules.ps1
# lub z audytem:
.\scripts\Install-Modules.ps1 -IncludeExchangeOnline
```

### 12.2 Konfiguracja settings
Skopiuj:
- `scripts/settings.example.json` → `scripts/settings.json`  
Uzupełnij `TenantAdminUrl`.

### 12.3 Governance report
```powershell
.\scripts\Get-SPOGovernanceReport.ps1 -SettingsPath .\scripts\settings.json
```

### 12.4 Raport perms dla site’a (PnP)
```powershell
.\scripts\Get-PnPSitePermissionsReport.ps1 -SiteUrl "https://TENANT.sharepoint.com/sites/ProjektX" -OutputPath .\scripts\reports
```

### 12.5 Ograniczenie wersjonowania (PnP) – ostrożnie
```powershell
.\scripts\Set-PnPDocumentLibrariesVersioning.ps1 -SiteUrl "https://TENANT.sharepoint.com/sites/ProjektX" -MaxVersions 200 -WhatIf
```

---

Koniec modułu. W praktyce najważniejsze jest to, żeby admin miał:
- **raporty** (site’y, storage, sharing, ownerzy),
- **standardy** (governance),
- **playbook incydentów** (audyt + perms),
- **automatyzację** (SPO + PnP).
