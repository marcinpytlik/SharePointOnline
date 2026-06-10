# SharePoint Online – Best practices tworzenia site’ów (admin)

Ten dokument zbiera praktyczne zasady tworzenia i utrzymania site’ów w SharePoint Online tak, żeby środowisko było skalowalne (bez „dżungli site’ów”, chaosu uprawnień i eksplozji storage).

---

## 1) Najpierw decyzja: po co jest ten site?

Najczęstsze typy i ich sens:

- **Team site (z Microsoft 365 Group / często z Teamsem)**  
  Do pracy operacyjnej zespołu: pliki, współpraca, zadania, kanały.
- **Communication site**  
  Do publikacji: intranet, ogłoszenia, strony działów (bardziej „czytaj”, mniej „edytuj”).
- **Hub site**  
  Nie jako „kolejny site”, tylko jako **spoiwo** (nawigacja, tematyka, wyszukiwanie) dla wielu site’ów.

**Zasada:**  
Nie rób *Team site* do publikacji intranetowej i nie rób *Communication site* do pracy projektowej.

---

## 2) Governance minimalne, które faktycznie działa (80/20)

Cztery reguły, które robią większość roboty:

### A. Konwencja nazw + opis
- Nazwa ma mówić *kto* i *po co*: np. `DEP-FIN-Polityki`, `PRJ-ERP-Wdrozenie`
- Opis obowiązkowy: 1–2 zdania „do czego służy” + owner/sponsor.

### B. Zawsze 2 właścicieli (Owners)
- Jeden owner = single point of failure.
- Ownerzy to sponsorzy biznesowi, nie „techniczni admini”.

### C. Uprawnienia przez grupy, nie osoby
- Owners / Members / Visitors (lub M365 Group Owners/Members)
- Unikaj ręcznego dodawania pojedynczych osób jako standardu.

### D. Lifecycle
- Data przeglądu (np. co 90 dni) i zasada archiwizacji/usunięcia.
- Site bez ownera = do naprawy lub zamknięcia.

---

## 3) Udostępnianie: tenant jako sufit, site jako precyzja

- Globalnie ustaw „maksymalny sufit” (żeby nie dało się zrobić katastrofy),
- Realną politykę dopasuj **per-site** do wrażliwości danych.

**Dobra praktyka (dla wrażliwych site’ów):**
- brak **anonymous links**,
- goście tylko **existing**,
- linki typu **Specific people**.

---

## 4) Struktura informacji: foldery OK, ale niech nie rządzą światem

- Foldery są OK do prostych struktur (np. dział/projekt/rok),
- Jeśli główną potrzebą jest „szukanie i filtrowanie” → **metadane + widoki** wygrywają.

**Sygnał alarmowy:**  
Jeśli użytkownicy klikają 5 folderów w głąb, żeby znaleźć plik — warto przeprojektować.

---

## 5) Biblioteki i wersjonowanie (czyli kontrola storage)

- Wersjonowanie **włącz**, ale ustaw limity (np. 100–500),
- Duże pliki często edytowane (PPTX/MP4) → rozważ mniejszy limit i/lub osobne biblioteki.

**Pro tip:**  
Rozdziel „Robocze” od „Final” (2 biblioteki). Robocza ma więcej zmian, finalna ma porządek.

---

## 6) Uprawnienia: nie łam dziedziczenia na itemach (na serio)

- Unikalne uprawnienia na plikach/folderach to generator chaosu i ticketów.
- Jeśli musisz izolować dostęp, lepiej:
  - osobna biblioteka,
  - albo osobny site,
  - albo private/shared channel w Teams — ale świadomie.

---

## 7) Teams i SharePoint: to jest jeden ekosystem

Jeśli powstaje Team w Teams — powstaje też site w SharePoint (pliki kanałów są w SPO).  
Dlatego governance tworzenia Teamów = governance tworzenia site’ów.

**Dobra praktyka:**  
Kontroluj kto może tworzyć M365 Groups/Teams (albo wymuś naming + 2 owners + opis).

---

## 8) Compliance: etykiety, retencja, DLP – najlepiej na starcie

Jeśli organizacja używa compliance, to najlepszy moment jest **podczas tworzenia**:
- sensitivity label dla site (jeśli wdrożone),
- domyślne zasady udostępniania,
- retencja dla treści / typów treści.

---

## 9) Provisioning jako proces (nawet jeśli początkowo ręczny)

Najprostszy workflow, który działa:

1. Request (formularz: nazwa, cel, owner1/owner2, typ, sharing)
2. Approval (IT / owner danych)
3. Provision (szablon ustawień)
4. Przegląd po 30 dniach (czy site żyje i czy ma sens)

Nudne = stabilne.

---

## 10) Minimalna checklista tworzenia site’a

- [ ] Wybrany typ: Team site / Communication site
- [ ] Nazwa zgodna ze standardem + opis
- [ ] Minimum 2 ownerów
- [ ] Sharing ustawiony per-site
- [ ] Wersjonowanie + limit wersji
- [ ] Domyślne grupy i uprawnienia (bez indywidualnych wyjątków)
- [ ] Plan lifecycle (review date / archiwizacja)
- [ ] (opcjonalnie) label/retencja/DLP zgodnie z polityką

---
