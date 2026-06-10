# 55215 Automation Edition — Przygotowanie środowiska laboratoryjnego

## Cel dokumentu

Ten dokument opisuje minimalne przygotowanie środowiska potrzebnego do realizacji kursu SharePoint Online Power User — Automation Edition.

---

## Wymagania dla uczestnika

Uczestnik powinien mieć:

- konto Microsoft 365,
- dostęp do SharePoint Online,
- dostęp do Power Automate,
- możliwość tworzenia list SharePoint,
- możliwość tworzenia bibliotek dokumentów,
- możliwość tworzenia przepływów Power Automate,
- skrzynkę Outlook w Microsoft 365,
- możliwość odbierania wiadomości e-mail,
- opcjonalnie dostęp do Microsoft Teams.

---

## Wymagania dla trenera

Trener powinien mieć:

- konto z uprawnieniami do przygotowania witryn szkoleniowych,
- możliwość tworzenia testowych użytkowników lub grup,
- przygotowaną witrynę demonstracyjną,
- przygotowane przykładowe dokumenty,
- przygotowaną listę testowych adresów e-mail,
- możliwość pokazania historii uruchomień przepływów,
- dostęp do Power Automate.

---

## Proponowana struktura środowiska

### Witryny

| Nazwa | Przeznaczenie |
|---|---|
| SPO-55215-Demo | witryna demonstracyjna trenera |
| SPO-55215-Lab-01 | środowisko grupy lub pierwszego zespołu |
| SPO-55215-Lab-02 | środowisko zapasowe |

### Listy

| Lista | Przeznaczenie |
|---|---|
| Wnioski zakupowe | główna lista do automatyzacji |
| Rejestr decyzji | lista pomocnicza do zapisu historii decyzji |
| Zadania procesu | opcjonalna lista zadań po zatwierdzeniu |

### Biblioteki

| Biblioteka | Przeznaczenie |
|---|---|
| Dokumenty zakupowe | dokumenty powiązane z wnioskami |
| Umowy | ćwiczenia z zatwierdzaniem dokumentów |
| Procedury | ćwiczenia ze stronami i metadanymi |

---

## Minimalne kolumny listy „Wnioski zakupowe”

| Nazwa kolumny | Typ | Wymagana | Uwagi |
|---|---|---|---|
| Title | Tekst | Tak | Tytuł wniosku |
| Kwota | Waluta lub liczba | Tak | Używana w warunku przepływu |
| Uzasadnienie | Wiele wierszy tekstu | Nie | Opis potrzeby zakupowej |
| Osoba zgłaszająca | Osoba lub grupa | Tak | Autor biznesowy wniosku |
| Osoba zatwierdzająca | Osoba lub grupa | Tak | Adresat approval |
| Status | Wybór | Tak | Status procesu |
| Data zgłoszenia | Data i godzina | Nie | Może być ustawiana automatycznie |
| Data decyzji | Data i godzina | Nie | Uzupełniana przez przepływ |
| Komentarz decyzji | Wiele wierszy tekstu | Nie | Komentarz z approval |
| Priorytet | Wybór | Nie | Niski, Normalny, Wysoki |

---

## Wartości kolumny Status

- Nowy
- W trakcie akceptacji
- Zatwierdzony
- Odrzucony
- Do uzupełnienia
- Zamknięty

---

## Minimalne kolumny biblioteki „Umowy”

| Nazwa kolumny | Typ | Wymagana | Uwagi |
|---|---|---|---|
| Typ dokumentu | Wybór | Tak | Umowa, Aneks, Oferta |
| Status dokumentu | Wybór | Tak | Roboczy, Do akceptacji, Zatwierdzony, Odrzucony |
| Właściciel dokumentu | Osoba lub grupa | Tak | Osoba odpowiedzialna |
| Osoba zatwierdzająca | Osoba lub grupa | Tak | Adresat approval |
| Data decyzji | Data i godzina | Nie | Uzupełniana przez przepływ |
| Komentarz decyzji | Wiele wierszy tekstu | Nie | Komentarz zatwierdzającego |

---

## Dane testowe

### Przykładowe wnioski

| Tytuł | Kwota | Priorytet | Status |
|---|---:|---|---|
| Zakup myszy ergonomicznej | 150 | Normalny | Nowy |
| Zakup monitora 32 cale | 1800 | Wysoki | Nowy |
| Zakup licencji narzędzia BI | 5000 | Wysoki | Nowy |
| Zakup materiałów biurowych | 300 | Niski | Nowy |

### Przykładowe dokumenty

- Umowa_testowa_001.docx
- Oferta_dostawcy_001.pdf
- Aneks_testowy_001.docx
- Procedura_zakupowa.docx

---

## Checklista przed szkoleniem

- [ ] Uczestnicy mają konta Microsoft 365.
- [ ] Uczestnicy mogą wejść do SharePoint Online.
- [ ] Uczestnicy mogą wejść do Power Automate.
- [ ] Uczestnicy mogą tworzyć przepływy.
- [ ] Uczestnicy mogą wysyłać i odbierać e-maile.
- [ ] Utworzono witrynę demonstracyjną.
- [ ] Przygotowano listę „Wnioski zakupowe”.
- [ ] Przygotowano bibliotekę „Umowy”.
- [ ] Przygotowano przykładowe dokumenty.
- [ ] Sprawdzono, czy approval działa w tenantcie.
- [ ] Sprawdzono, czy przepływy nie są blokowane przez polityki organizacji.

---

## Ryzyka środowiskowe

| Ryzyko | Objaw | Plan awaryjny |
|---|---|---|
| Brak licencji Power Automate | uczestnik nie może utworzyć przepływu | praca w parach lub pokaz trenera |
| Brak uprawnień do witryny | błąd przy tworzeniu listy | trener dodaje uczestnika do właścicieli/członków |
| Polityki DLP blokują konektor | przepływ nie zapisuje się lub nie działa | użyć tylko SharePoint + Outlook |
| Approval nie dochodzi | brak wiadomości lub oczekującej decyzji | sprawdzić Teams/Outlook/Power Automate approvals |
| Zmiana nazw kolumn | przepływ traci mapowanie | poprawić akcje i dynamic content |

