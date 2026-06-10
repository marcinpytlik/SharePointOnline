# SharePoint Online – Opis site’ów i szablony (templates)

Ten dokument opisuje najczęściej używane typy site’ów w SharePoint Online oraz daje gotowe „szablony” (standardy) do wdrożenia: cel, kiedy używać, ustawienia domyślne, role i checklistę provisioningu.

---

## 1) Team site (strona zespołowa)

### Cel
Praca operacyjna zespołu/projektu: pliki robocze, współdzielenie, procesy, notatki, lista zadań, szybka współpraca.

### Kiedy używać
- zespół pracuje aktywnie na wspólnych plikach,
- potrzebujesz współpracy w czasie rzeczywistym (Office online/desktop),
- site ma „żyć” na co dzień.

### Kiedy NIE używać
- jako intranet/portal publikacyjny dla całej firmy,
- jako archiwum dokumentów „tylko do czytania” (lepszy Communication site).

### Typowe cechy
- często powiązany z **Microsoft 365 Group** (a często też z **Teamsem**),
- uprawnienia oparte o Owners/Members/Visitors (lub Owners/Members grupy M365),
- sporo edycji → ważne limity wersjonowania i porządek w bibliotekach.

### Szablon (standard) – ustawienia domyślne
**Nazwa:** `PRJ-<nazwa>` lub `DEP-<dzial>-<temat>`  
**Właściciele:** min. 2 owners  
**Sharing:** per-site (zależnie od klasyfikacji danych)  
**Biblioteki:**
- `Documents` (robocze) – wersjonowanie ON, limit np. 200
- `Final` (finalne) – wersjonowanie ON, limit np. 50–100
**Uprawnienia:** grupy, bez wyjątków item-level jako standard  
**Lifecycle:** review co 90 dni + archiwizacja po zakończeniu projektu

### Provisioning checklist (skrót)
- [ ] Nazwa + opis + 2 owners
- [ ] Polityka sharing ustawiona per-site
- [ ] Wersjonowanie + limity
- [ ] Biblioteka „Final” utworzona
- [ ] Widoki/metadane (opcjonalnie)
- [ ] Data przeglądu lifecycle

---

## 2) Communication site (strona komunikacyjna)

### Cel
Publikacja informacji: intranet, ogłoszenia, procedury, komunikaty, content „do konsumowania”.

### Kiedy używać
- treść ma być czytana przez wiele osób,
- edycja ma być ograniczona do redaktorów,
- potrzebujesz estetycznych stron, newsów, webpartów.

### Kiedy NIE używać
- do intensywnej współpracy zespołu nad plikami (lepszy Team site),
- jako miejsce do chaosu folderów i uprawnień.

### Typowe cechy
- mała grupa edytorów, duża grupa odbiorców,
- mniej zmian w plikach → łatwiej utrzymać porządek,
- sensowne miejsce na procedury i polityki firmowe.

### Szablon (standard) – ustawienia domyślne
**Nazwa:** `COM-<obszar>` np. `COM-HR-Komunikaty`  
**Właściciele:** 2 owners (business) + rola redaktorów  
**Sharing:** zwykle bez external; linki anonimowe OFF  
**Uprawnienia:** Visitors = szeroko, Members/Editors = wąsko  
**Biblioteki:**
- `Procedury` – wersjonowanie ON, limit np. 50–100
- `Załączniki` – porządek + widoki
**Lifecycle:** przegląd kwartalny treści (aktualność)

### Provisioning checklist (skrót)
- [ ] Nazwa + opis + 2 owners
- [ ] Grupa redaktorów (Members/Editors)
- [ ] Sharing ograniczony
- [ ] Biblioteki „Procedury”, „Załączniki”
- [ ] Widoki + metadata (np. kategoria, obszar, data aktualizacji)

---

## 3) Hub site (site-hub)

### Cel
Spina wiele site’ów tematycznie: wspólna nawigacja, brandowanie, wyszukiwanie, agregacje treści.

### Kiedy używać
- masz wiele site’ów dla jednego obszaru (np. HR, IT, Projekty),
- chcesz „portal” bez wrzucania wszystkiego do jednego site’a,
- potrzebujesz spójnej nawigacji i doświadczenia użytkownika.

### Kiedy NIE używać
- jako „kolejny site do dokumentów”,
- bez pomysłu na strukturę (hub bez governance = chaos).

### Typowe cechy
- dołączasz site’y jako „associated sites”,
- hub sam w sobie może być Communication site (często),
- governance: kto może dołączać site’y do huba.

### Szablon (standard) – ustawienia domyślne
**Nazwa:** `HUB-<obszar>` np. `HUB-Projekty`  
**Ownerzy:** właściciele obszaru (np. PMO) + IT jako wsparcie  
**Polityka dołączania:** kontrolowana (nie każdy może „podpiąć” site)  
**Nawigacja:** spójna, krótka, logiczna  
**Lifecycle:** przegląd listy site’ów w hubie co kwartał

### Provisioning checklist (skrót)
- [ ] Określ obszar i zasady dołączania site’ów
- [ ] Ustal nawigację i standard nazewnictwa
- [ ] Ustal ownerów huba i proces „associate site”
- [ ] Przegląd kwartalny: martwe site’y / niepasujące do huba

---

## 4) Project site (szablon operacyjny – wariant Team site)

### Cel
Szybka, powtarzalna struktura dla projektów (współpraca + dokumentacja).

### Szablon (standard) – propozycja struktury
**Nazwa:** `PRJ-<nazwa>-<rok>`  
**Biblioteki:**
- `01_Wymagania`
- `02_Analizy`
- `03_Realizacja`
- `04_Test`
- `05_Wdrozenie`
- `99_Final`
**Wersjonowanie:** ON, limit 200 (robocze), 100 (final)  
**Role:**
- Owners: sponsor + PM
- Members: zespół projektowy
- Visitors: interesariusze (read-only)

**Uwaga:** jeśli foldery robią się głębokie → przejdź na metadane + widoki.

---

## 5) Department site (szablon działowy – wariant Communication site)

### Cel
Strona działu: komunikacja, procedury, newsy, dokumenty referencyjne.

### Szablon (standard)
**Nazwa:** `DEP-<dzial>` np. `DEP-FIN`  
**Strony:**
- Start (news)
- Procedury
- FAQ
- Kontakt
**Biblioteki:**
- `Procedury` (kategoria, wersja, data aktualizacji)
- `Szablony` (formularze, wzory)
**Uprawnienia:**
- Visitors: cała organizacja
- Editors: wybrani pracownicy działu

---

## 6) Szablon „Sensitive” (site z danymi wrażliwymi)

### Cel
Dane wymagające zwiększonej kontroli.

### Szablon (standard)
- Sharing: **bez anonymous links**
- External: **existing guests only** lub wyłączone
- Dostęp: preferuj urządzenia zarządzane (jeśli polityki to wspierają)
- Uprawnienia: tylko grupy, zakaz item-level perms jako standard
- Audyt: wymagany + okresowe przeglądy

---

## 7) Template „Szybka karta” (do wklejenia w proces requestu)

**Nazwa site’a:**  
**Typ:** Team / Communication / Hub  
**Cel (1–2 zdania):**  
**Owner 1 / Owner 2:**  
**Członkowie (grupy):**  
**Sharing (poziom):**  
**Dane wrażliwe:** Tak/Nie  
**Wersjonowanie (limit):**  
**Review date (90 dni):**  

---
