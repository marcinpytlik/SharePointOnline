# SharePoint Online — Managed Metadata Service i menu dla portalu korporacyjnego

## Cel dokumentu

Celem dokumentu jest opisanie praktycznego podejścia do budowy menu oraz klasyfikacji treści w portalu korporacyjnym opartym o SharePoint Online.

Dokument rozróżnia dwie ważne warstwy:

- **menu / nawigacja portalu**,
- **Managed Metadata Service / Term Store** jako mechanizm klasyfikacji treści.

---

## Najważniejsza rekomendacja

Dla nowoczesnego portalu korporacyjnego w SharePoint Online nie zaleca się budowania całej głównej nawigacji wyłącznie na Managed Metadata Service.

Lepsze podejście:

```text
Home Site
+ Hub Site
+ Global Navigation
+ Hub Navigation
+ Mega Menu
+ Managed Metadata do klasyfikacji treści
```

Managed Metadata Service powinien służyć głównie do:

- klasyfikowania dokumentów,
- tagowania treści,
- budowy widoków,
- filtrowania bibliotek,
- wspierania wyszukiwania,
- utrzymania spójnego słownika pojęć,
- porządkowania dokumentów według działów, procesów, systemów i typów.

---

## Prosta zasada projektowa

```text
Menu = droga dla użytkownika
Metadata = porządek w treści
```

Menu powinno prowadzić użytkownika do najważniejszych miejsc w portalu.

Managed Metadata powinno odpowiadać za logiczne opisanie zawartości, dokumentów, procedur, systemów i procesów.

---

# Proponowana architektura portalu

```text
Home Site
│
├── Global Navigation / SharePoint App Bar
│
├── Hub Site: Portal korporacyjny
│   ├── Site: Aktualności
│   ├── Site: HR
│   ├── Site: IT
│   ├── Site: Finanse
│   ├── Site: Dokumenty firmowe
│   ├── Site: Baza wiedzy
│   └── Site: Projekty
│
└── Term Store
    ├── Departments
    ├── Document Types
    ├── Business Processes
    ├── Systems
    ├── Locations
    ├── Confidentiality Levels
    ├── Document Statuses
    ├── Audiences
    └── Knowledge Areas
```

---

# Proponowane menu portalu korporacyjnego

## Poziom główny

```text
Start
Aktualności
Firma
Działy
Dokumenty
Procesy
Systemy
HR
IT
Finanse
Projekty
Baza wiedzy
Kontakt
```

---

## Start

```text
Start
├── Aktualności firmowe
├── Komunikaty zarządu
├── Ważne linki
├── Kalendarz wydarzeń
└── Ostatnio dodane
```

### Przeznaczenie

Sekcja startowa powinna być miejscem wejściowym do portalu. Powinna pokazywać najważniejsze komunikaty, wiadomości, linki i skróty do często używanych zasobów.

---

## Firma

```text
Firma
├── O nas
├── Struktura organizacyjna
├── Zarząd
├── Lokalizacje
├── Strategia
├── Polityki firmowe
└── Kontakt
```

### Przeznaczenie

Sekcja „Firma” zawiera informacje ogólne o organizacji. Jest przeznaczona zarówno dla nowych, jak i obecnych pracowników.

---

## Działy

```text
Działy
├── HR
├── IT
├── Finanse
├── Księgowość
├── Sprzedaż
├── Marketing
├── Produkcja
├── Logistyka
└── Administracja
```

### Przeznaczenie

Sekcja „Działy” prowadzi użytkownika do stron poszczególnych jednostek organizacyjnych.

Każdy dział może mieć własną stronę lub osobny site podpięty do huba.

Przykład strony działu:

```text
HR
├── Aktualności HR
├── Dokumenty HR
├── Formularze HR
├── FAQ HR
└── Kontakt do HR
```

---

## Dokumenty

```text
Dokumenty
├── Procedury
├── Regulaminy
├── Instrukcje
├── Formularze
├── Szablony
├── Umowy
├── Dokumenty kadrowe
└── Dokumenty finansowe
```

### Przeznaczenie

Sekcja „Dokumenty” jest głównym wejściem do bibliotek dokumentów firmowych.

Dokumenty nie muszą być fizycznie kopiowane do wielu lokalizacji. Można je opisywać metadanymi i pokazywać w różnych widokach.

Przykład:

```text
Ten sam dokument może być widoczny w:
- Dokumenty → Procedury
- Finanse → Dokumenty działu
- Procesy → Obieg faktur
- Systemy → KSeF
```

---

## Procesy

```text
Procesy
├── Obieg dokumentów
├── Zakupy
├── Akceptacja faktur
├── Wnioski urlopowe
├── Onboarding
├── Offboarding
├── Obsługa klienta
└── Zgłoszenia IT
```

### Przeznaczenie

Sekcja „Procesy” powinna prowadzić użytkownika do opisów najważniejszych procesów biznesowych.

Przykładowo proces „Akceptacja faktur” może zawierać:

- opis procesu,
- diagram procesu,
- role i odpowiedzialności,
- formularze,
- instrukcje,
- link do systemu,
- dokumenty powiązane z procesem.

---

## Systemy

```text
Systemy
├── ERP
├── CRM
├── Helpdesk
├── Kadry i płace
├── KSeF / faktury
├── BI / raporty
├── VPN
└── Inne aplikacje
```

### Przeznaczenie

Sekcja „Systemy” powinna zawierać wejścia do najważniejszych aplikacji firmowych oraz instrukcje ich używania.

Dla każdego systemu warto przygotować stronę zawierającą:

- opis systemu,
- link do systemu,
- właściciela biznesowego,
- właściciela technicznego,
- instrukcje użytkownika,
- FAQ,
- kontakt do wsparcia,
- dokumenty powiązane.

---

## Baza wiedzy

```text
Baza wiedzy
├── Instrukcje użytkownika
├── FAQ
├── Poradniki IT
├── Standardy pracy
├── Materiały szkoleniowe
└── Nagrania
```

### Przeznaczenie

Baza wiedzy powinna gromadzić instrukcje, materiały szkoleniowe, FAQ i poradniki.

To dobre miejsce na treści typu:

- jak złożyć wniosek urlopowy,
- jak zgłosić problem do IT,
- jak korzystać z VPN,
- jak znaleźć dokument firmowy,
- jak korzystać z systemu ERP,
- jak przygotować dokument do akceptacji.

---

# Gdzie wykorzystać Managed Metadata Service

Managed Metadata Service powinien być użyty do opisania treści, a niekoniecznie jako mechanizm głównego menu.

Przykład:

Użytkownik klika w menu:

```text
Dokumenty → Procedury
```

A w bibliotece dokumentów znajdują się kolumny Managed Metadata:

```text
Dział
Typ dokumentu
Proces
System
Poziom poufności
Status dokumentu
Właściciel biznesowy
Lokalizacja
Język
```

Dzięki temu można tworzyć widoki:

```text
Procedury HR
Procedury finansowe
Dokumenty dla procesu obiegu faktur
Dokumenty związane z KSeF
Dokumenty poufne
Dokumenty do akceptacji
Dokumenty opublikowane
```

---

# Proponowana struktura Term Store

## Grupa

```text
Corporate Portal
```

## Term Sety

```text
Corporate Portal
├── Departments
├── Document Types
├── Business Processes
├── Systems
├── Locations
├── Confidentiality Levels
├── Document Statuses
├── Audiences
└── Knowledge Areas
```

---

## Term Set: Departments

```text
Departments
├── Zarząd
├── HR
├── IT
├── Finanse
├── Księgowość
├── Sprzedaż
├── Marketing
├── Produkcja
├── Logistyka
├── Administracja
└── Bezpieczeństwo
```

### Zastosowanie

Term Set „Departments” służy do oznaczania, którego działu dotyczy dana treść lub dokument.

Przykłady użycia:

```text
Dział = HR
Dział = IT
Dział = Finanse
Dział = Produkcja
```

---

## Term Set: Document Types

```text
Document Types
├── Procedura
├── Instrukcja
├── Regulamin
├── Formularz
├── Szablon
├── Polityka
├── Umowa
├── Raport
├── Prezentacja
└── Materiał szkoleniowy
```

### Zastosowanie

Term Set „Document Types” służy do klasyfikowania rodzaju dokumentu.

Przykłady użycia:

```text
Typ dokumentu = Procedura
Typ dokumentu = Instrukcja
Typ dokumentu = Formularz
Typ dokumentu = Polityka
```

---

## Term Set: Business Processes

```text
Business Processes
├── Zakupy
├── Sprzedaż
├── Obsługa klienta
├── Obieg faktur
├── Rekrutacja
├── Onboarding
├── Offboarding
├── Zarządzanie incydentami
├── Zarządzanie zmianą
└── Raportowanie
```

### Zastosowanie

Term Set „Business Processes” służy do powiązania dokumentu lub strony z procesem biznesowym.

Przykład:

```text
Proces = Obieg faktur
Proces = Onboarding
Proces = Zarządzanie incydentami
```

---

## Term Set: Systems

```text
Systems
├── ERP
├── CRM
├── SharePoint
├── Teams
├── Exchange Online
├── Power BI
├── Helpdesk
├── KSeF
├── Kadry i płace
└── VPN
```

### Zastosowanie

Term Set „Systems” pozwala powiązać treści i dokumenty z konkretnymi systemami informatycznymi.

Przykład:

```text
System = ERP
System = KSeF
System = Helpdesk
System = Power BI
```

---

## Term Set: Confidentiality Levels

```text
Confidentiality Levels
├── Publiczne
├── Wewnętrzne
├── Poufne
├── Ściśle poufne
└── Dane osobowe
```

### Zastosowanie

Term Set „Confidentiality Levels” służy do oznaczania poziomu poufności dokumentów.

Przykład:

```text
Poziom poufności = Wewnętrzne
Poziom poufności = Poufne
Poziom poufności = Dane osobowe
```

---

## Term Set: Document Statuses

```text
Document Statuses
├── Roboczy
├── Do akceptacji
├── Zatwierdzony
├── Opublikowany
├── Archiwalny
└── Wycofany
```

### Zastosowanie

Term Set „Document Statuses” pozwala śledzić cykl życia dokumentu.

Przykład:

```text
Status = Roboczy
Status = Do akceptacji
Status = Opublikowany
Status = Wycofany
```

---

## Term Set: Audiences

```text
Audiences
├── Wszyscy pracownicy
├── Kierownicy
├── Zarząd
├── HR
├── IT
├── Finanse
├── Pracownicy produkcji
├── Pracownicy biurowi
└── Nowi pracownicy
```

### Zastosowanie

Term Set „Audiences” można wykorzystać do opisywania grup odbiorców treści.

Uwaga: to nie zastępuje uprawnień. To jest klasyfikacja treści.

---

## Term Set: Knowledge Areas

```text
Knowledge Areas
├── Procedury firmowe
├── Bezpieczeństwo informacji
├── IT dla użytkownika
├── HR i kadry
├── Finanse
├── Sprzedaż
├── Obsługa klienta
├── Raportowanie
└── Szkolenia
```

### Zastosowanie

Term Set „Knowledge Areas” może być używany w bazie wiedzy do porządkowania artykułów i instrukcji.

---

# Przykład biblioteki: Dokumenty firmowe

## Proponowane kolumny

```text
Nazwa dokumentu
Typ dokumentu
Dział
Proces
System
Poziom poufności
Status
Data obowiązywania
Właściciel dokumentu
Wersja
Data przeglądu
```

## Typy kolumn

| Kolumna | Typ kolumny | Źródło |
|---|---|---|
| Nazwa dokumentu | Tekst | SharePoint |
| Typ dokumentu | Managed Metadata | Document Types |
| Dział | Managed Metadata | Departments |
| Proces | Managed Metadata | Business Processes |
| System | Managed Metadata | Systems |
| Poziom poufności | Managed Metadata | Confidentiality Levels |
| Status | Managed Metadata | Document Statuses |
| Data obowiązywania | Date | SharePoint |
| Właściciel dokumentu | Person | Microsoft 365 |
| Wersja | Tekst / Number | SharePoint |
| Data przeglądu | Date | SharePoint |

---

# Przykład dokumentu

```text
Nazwa: Procedura akceptacji faktur kosztowych
Typ dokumentu: Procedura
Dział: Finanse
Proces: Obieg faktur
System: ERP / KSeF
Poziom poufności: Wewnętrzne
Status: Opublikowany
Właściciel dokumentu: Kierownik finansów
Data obowiązywania: 2026-01-01
Data przeglądu: 2026-12-31
```

Ten sam dokument może być wyświetlany w kilku miejscach portalu:

```text
Dokumenty → Procedury
Finanse → Dokumenty działu
Procesy → Obieg faktur
Systemy → KSeF
Baza wiedzy → Finanse
```

Nie trzeba tworzyć kilku kopii dokumentu.

Wystarczy:

```text
jeden dokument
+ dobre metadata
+ odpowiednie widoki
+ strony z webpartami
```

---

# Przykładowe widoki w bibliotece dokumentów

## Widok: Wszystkie dokumenty opublikowane

Filtr:

```text
Status = Opublikowany
```

## Widok: Procedury

Filtr:

```text
Typ dokumentu = Procedura
```

## Widok: Dokumenty HR

Filtr:

```text
Dział = HR
```

## Widok: Dokumenty finansowe

Filtr:

```text
Dział = Finanse
```

## Widok: Dokumenty dla procesu obiegu faktur

Filtr:

```text
Proces = Obieg faktur
```

## Widok: Dokumenty związane z KSeF

Filtr:

```text
System = KSeF
```

## Widok: Dokumenty do akceptacji

Filtr:

```text
Status = Do akceptacji
```

---

# Proponowany model stron

## Strona: HR

```text
HR
├── Aktualności HR
├── Dokumenty HR
├── Formularze HR
├── Procedury HR
├── FAQ HR
└── Kontakt do HR
```

Na stronie HR można użyć webpartu dokumentów lub wyróżnionej zawartości z filtrem:

```text
Dział = HR
```

---

## Strona: IT

```text
IT
├── Aktualności IT
├── Zgłoszenia IT
├── Instrukcje IT
├── Systemy IT
├── Bezpieczeństwo
├── FAQ IT
└── Kontakt do IT
```

Przykładowe filtry:

```text
Dział = IT
Typ dokumentu = Instrukcja
Knowledge Area = IT dla użytkownika
```

---

## Strona: Finanse

```text
Finanse
├── Aktualności finansowe
├── Procedury finansowe
├── Formularze finansowe
├── Obieg faktur
├── KSeF
├── Raporty
└── Kontakt do finansów
```

Przykładowe filtry:

```text
Dział = Finanse
Proces = Obieg faktur
System = KSeF
```

---

## Strona: System KSeF

```text
KSeF
├── Opis systemu
├── Link do systemu
├── Instrukcje
├── Procedury
├── FAQ
├── Kontakt do właściciela systemu
└── Dokumenty powiązane
```

Przykładowe filtry:

```text
System = KSeF
```

---

# Plan wdrożenia krok po kroku

## Krok 1 — przygotowanie struktury portalu

```text
1. Utwórz Communication Site jako główny portal.
2. Ustaw go jako Home Site.
3. Zarejestruj portal jako Hub Site.
4. Utwórz główne obszary:
   - Aktualności
   - HR
   - IT
   - Finanse
   - Dokumenty firmowe
   - Baza wiedzy
   - Projekty
5. Podepnij obszary do huba.
```

---

## Krok 2 — przygotowanie menu

```text
1. Wejdź na stronę główną portalu.
2. Przejdź do edycji nawigacji.
3. Włącz Mega Menu.
4. Dodaj główne sekcje:
   - Start
   - Firma
   - Działy
   - Dokumenty
   - Procesy
   - Systemy
   - Baza wiedzy
   - Kontakt
5. Nie przekraczaj 2–3 poziomów menu.
6. Tam, gdzie trzeba, użyj Audience Targeting.
```

---

## Krok 3 — przygotowanie Term Store

```text
1. Wejdź do SharePoint Admin Center.
2. Przejdź do Content services.
3. Otwórz Term store.
4. Utwórz grupę: Corporate Portal.
5. Utwórz term sety:
   - Departments
   - Document Types
   - Business Processes
   - Systems
   - Locations
   - Confidentiality Levels
   - Document Statuses
   - Audiences
   - Knowledge Areas
6. Uzupełnij terminy.
7. Określ właścicieli term setów.
8. Ustal, które term sety mają być zamknięte, a które otwarte.
```

---

## Krok 4 — przygotowanie kolumn Managed Metadata

```text
1. Utwórz site columns dla metadanych.
2. Podłącz kolumny do odpowiednich term setów.
3. Dodaj kolumny do bibliotek dokumentów.
4. Utwórz widoki na podstawie metadanych.
5. Przetestuj filtrowanie.
6. Przetestuj wyszukiwanie.
```

---

## Krok 5 — przygotowanie bibliotek

Przykładowe biblioteki:

```text
Dokumenty firmowe
Procedury
Formularze
Szablony
Materiały szkoleniowe
Baza wiedzy
```

Alternatywnie można użyć jednej większej biblioteki „Dokumenty firmowe” i porządkować ją metadanymi.

Rekomendacja:

```text
Nie tworzyć zbyt wielu bibliotek tylko dlatego, że istnieją różne typy dokumentów.
Najpierw sprawdzić, czy wystarczą metadane i widoki.
```

---

## Krok 6 — przygotowanie widoków

Dla biblioteki „Dokumenty firmowe” warto przygotować widoki:

```text
Wszystkie dokumenty
Dokumenty opublikowane
Dokumenty do akceptacji
Procedury
Instrukcje
Formularze
Dokumenty HR
Dokumenty IT
Dokumenty finansowe
Dokumenty według procesu
Dokumenty według systemu
Dokumenty archiwalne
```

---

## Krok 7 — przygotowanie stron działowych i procesowych

Przykładowe strony:

```text
HR
IT
Finanse
Obieg faktur
Onboarding
Zgłoszenia IT
KSeF
ERP
Baza wiedzy
```

Na każdej stronie można pokazać dokumenty powiązane za pomocą filtrów metadanych.

---

# Dobre praktyki

## 1. Nie budować zbyt głębokiego menu

Menu nie powinno mieć zbyt wielu poziomów.

Rekomendacja:

```text
maksymalnie 2–3 poziomy
```

Zbyt głębokie menu jest trudne w utrzymaniu i niewygodne dla użytkowników.

---

## 2. Nie kopiować dokumentów

Nie należy kopiować tego samego dokumentu do wielu bibliotek lub lokalizacji.

Lepszy model:

```text
jeden dokument
+ metadata
+ widoki
+ strony tematyczne
```

---

## 3. Używać spójnych nazw

Nazwy terminów powinny być spójne.

Przykład:

Źle:

```text
HR
Kadry
Human Resources
Dział Personalny
```

Dobrze:

```text
HR
```

Ewentualne inne nazwy można dodać jako synonimy lub aliasy.

---

## 4. Oddzielić uprawnienia od metadanych

Managed Metadata nie zastępuje uprawnień.

Przykład:

```text
Poziom poufności = Poufne
```

nie oznacza automatycznie, że dokument jest zabezpieczony.

Uprawnienia trzeba skonfigurować osobno.

---

## 5. Ustalić właścicieli słowników

Każdy ważny term set powinien mieć właściciela biznesowego.

Przykład:

| Term Set | Właściciel |
|---|---|
| Departments | Administracja / HR |
| Document Types | Zespół portalu / Compliance |
| Business Processes | Właściciele procesów |
| Systems | IT |
| Confidentiality Levels | Bezpieczeństwo / Compliance |
| Document Statuses | Zespół dokumentacji |
| Knowledge Areas | Zespół portalu |

---

## 6. Kontrolować rozrost terminów

Nie każdy użytkownik powinien móc dodawać nowe terminy.

Dla kluczowych term setów rekomendowany jest model zamknięty:

```text
Departments = zamknięty
Document Types = zamknięty
Confidentiality Levels = zamknięty
Document Statuses = zamknięty
Systems = kontrolowany
Knowledge Areas = kontrolowany
```

---

# Checklista wdrożeniowa

## Portal

```text
[ ] Utworzono Home Site
[ ] Utworzono Hub Site
[ ] Podpięto strony działowe do huba
[ ] Przygotowano stronę główną portalu
[ ] Przygotowano globalną nawigację
[ ] Przygotowano hub navigation
[ ] Włączono Mega Menu
[ ] Ograniczono menu do 2–3 poziomów
[ ] Przetestowano menu z kontem zwykłego użytkownika
```

---

## Term Store

```text
[ ] Utworzono grupę Corporate Portal
[ ] Utworzono term set Departments
[ ] Utworzono term set Document Types
[ ] Utworzono term set Business Processes
[ ] Utworzono term set Systems
[ ] Utworzono term set Locations
[ ] Utworzono term set Confidentiality Levels
[ ] Utworzono term set Document Statuses
[ ] Utworzono term set Audiences
[ ] Utworzono term set Knowledge Areas
[ ] Ustalono właścicieli term setów
[ ] Ustalono zasady dodawania nowych terminów
```

---

## Biblioteki dokumentów

```text
[ ] Utworzono bibliotekę Dokumenty firmowe
[ ] Dodano kolumnę Typ dokumentu
[ ] Dodano kolumnę Dział
[ ] Dodano kolumnę Proces
[ ] Dodano kolumnę System
[ ] Dodano kolumnę Poziom poufności
[ ] Dodano kolumnę Status
[ ] Dodano kolumnę Właściciel dokumentu
[ ] Dodano kolumnę Data obowiązywania
[ ] Dodano kolumnę Data przeglądu
[ ] Przygotowano widoki
[ ] Przetestowano filtrowanie
[ ] Przetestowano wyszukiwanie
```

---

## Strony

```text
[ ] Przygotowano stronę HR
[ ] Przygotowano stronę IT
[ ] Przygotowano stronę Finanse
[ ] Przygotowano stronę Dokumenty
[ ] Przygotowano stronę Procesy
[ ] Przygotowano stronę Systemy
[ ] Przygotowano stronę Baza wiedzy
[ ] Dodano webparty z dokumentami filtrowanymi po metadanych
[ ] Przetestowano strony z kontem użytkownika
```

---

# Rekomendowany wariant końcowy

```text
Menu główne:
SharePoint Home Site + Hub Navigation + Mega Menu

Klasyfikacja dokumentów:
Managed Metadata Service / Term Store

Filtrowanie i wyszukiwanie:
Managed Metadata columns + widoki + webparty

Personalizacja:
Audience Targeting na linkach menu i webpartach

Bezpieczeństwo:
Uprawnienia SharePoint / Microsoft 365 Groups / Entra ID
```

---

# Podsumowanie

Managed Metadata Service jest bardzo dobrym mechanizmem do porządkowania treści w SharePoint Online, ale nie powinien być traktowany jako jedyny fundament głównego menu portalu.

Najlepsze podejście dla portalu korporacyjnego:

```text
1. Menu prowadzi użytkownika do głównych obszarów.
2. Managed Metadata porządkuje dokumenty i treści.
3. Widoki i webparty pokazują zawartość w odpowiednim kontekście.
4. Dokument istnieje raz, ale może być widoczny w wielu miejscach.
5. Uprawnienia są zarządzane osobno od metadanych.
```

Najkrócej:

```text
Menu = nawigacja
Metadata = klasyfikacja
Widoki = prezentacja
Uprawnienia = bezpieczeństwo
```
