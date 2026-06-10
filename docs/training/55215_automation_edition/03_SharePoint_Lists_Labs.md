# 55215 Automation Edition — Laboratoria SharePoint Lists

## Cel pliku

Ten plik zawiera ćwiczenia dotyczące list SharePoint, przygotowane specjalnie pod późniejszą automatyzację w Power Automate.

---

# Lab 01 — Utworzenie listy „Wnioski zakupowe”

## Cel ćwiczenia

Utworzenie listy SharePoint, która będzie pełnić rolę rejestru wniosków zakupowych.

## Scenariusz biznesowy

Dział chce odejść od obsługi wniosków zakupowych przez e-mail. Każdy wniosek ma być rejestrowany na liście SharePoint, a później obsługiwany przez Power Automate.

## Kroki

1. Wejdź do witryny SharePoint przygotowanej na szkolenie.
2. Wybierz **New** / **Nowy**.
3. Wybierz **List** / **Lista**.
4. Utwórz pustą listę.
5. Nazwij listę: `Wnioski zakupowe`.
6. Dodaj opis: `Rejestr wniosków zakupowych obsługiwanych przez Power Automate`.
7. Utwórz listę.

## Weryfikacja

- [ ] Lista istnieje.
- [ ] Lista jest widoczna w nawigacji witryny.
- [ ] Lista ma kolumnę Title.

---

# Lab 02 — Dodanie kolumn procesowych

## Cel ćwiczenia

Dodanie kolumn, które będą wykorzystywane przez użytkowników oraz przepływy Power Automate.

## Kolumny do dodania

| Nazwa | Typ | Wymagana |
|---|---|---|
| Kwota | Number albo Currency | Tak |
| Uzasadnienie | Multiple lines of text | Nie |
| Osoba zgłaszająca | Person or Group | Tak |
| Osoba zatwierdzająca | Person or Group | Tak |
| Status | Choice | Tak |
| Data decyzji | Date and Time | Nie |
| Komentarz decyzji | Multiple lines of text | Nie |
| Priorytet | Choice | Nie |

## Wartości kolumny Status

- Nowy
- W trakcie akceptacji
- Zatwierdzony
- Odrzucony
- Do uzupełnienia
- Zamknięty

## Wartości kolumny Priorytet

- Niski
- Normalny
- Wysoki

## Kroki

1. Otwórz listę `Wnioski zakupowe`.
2. Dodaj kolumnę `Kwota`.
3. Dodaj kolumnę `Uzasadnienie`.
4. Dodaj kolumnę `Osoba zgłaszająca`.
5. Dodaj kolumnę `Osoba zatwierdzająca`.
6. Dodaj kolumnę `Status` jako Choice.
7. Dodaj kolumnę `Data decyzji`.
8. Dodaj kolumnę `Komentarz decyzji`.
9. Dodaj kolumnę `Priorytet`.

## Weryfikacja

- [ ] Wszystkie kolumny istnieją.
- [ ] Status ma poprawne wartości.
- [ ] Priorytet ma poprawne wartości.
- [ ] Wymagane kolumny są oznaczone jako wymagane.

---

# Lab 03 — Widoki według statusów

## Cel ćwiczenia

Utworzenie widoków, które ułatwią pracę z procesem.

## Widoki do utworzenia

| Widok | Filtr |
|---|---|
| Nowe wnioski | Status = Nowy |
| W trakcie akceptacji | Status = W trakcie akceptacji |
| Zatwierdzone | Status = Zatwierdzony |
| Odrzucone | Status = Odrzucony |
| Wszystkie aktywne | Status != Zamknięty |

## Kroki

1. Otwórz listę `Wnioski zakupowe`.
2. Utwórz nowy widok `Nowe wnioski`.
3. Ustaw filtr: `Status` równa się `Nowy`.
4. Utwórz widok `W trakcie akceptacji`.
5. Ustaw filtr: `Status` równa się `W trakcie akceptacji`.
6. Utwórz widok `Zatwierdzone`.
7. Utwórz widok `Odrzucone`.
8. Utwórz widok `Wszystkie aktywne`.

## Weryfikacja

- [ ] Widoki są dostępne z poziomu listy.
- [ ] Widoki filtrują elementy zgodnie ze statusem.
- [ ] Widoki będą użyteczne podczas testów Power Automate.

---

# Lab 04 — Dane testowe

## Cel ćwiczenia

Dodanie przykładowych wniosków, które posłużą do testów automatyzacji.

## Dane

| Title | Kwota | Priorytet | Status |
|---|---:|---|---|
| Zakup myszy ergonomicznej | 150 | Normalny | Nowy |
| Zakup monitora 32 cale | 1800 | Wysoki | Nowy |
| Zakup licencji narzędzia BI | 5000 | Wysoki | Nowy |
| Zakup materiałów biurowych | 300 | Niski | Nowy |

## Kroki

1. Dodaj pierwszy element.
2. Uzupełnij tytuł, kwotę, osobę zgłaszającą, osobę zatwierdzającą, status i priorytet.
3. Zapisz element.
4. Dodaj pozostałe elementy.

## Weryfikacja

- [ ] Lista zawiera minimum 4 elementy.
- [ ] Elementy mają różne kwoty.
- [ ] Elementy mają status `Nowy`.
- [ ] Elementy można filtrować widokami.

---

# Lab 05 — Przygotowanie listy pod Power Automate

## Cel ćwiczenia

Sprawdzenie, czy lista jest gotowa do automatyzacji.

## Checklista

- [ ] Lista ma stabilną nazwę.
- [ ] Kolumny mają zrozumiałe nazwy.
- [ ] Status procesu jest kolumną typu Choice.
- [ ] Osoba zatwierdzająca jest kolumną typu Person.
- [ ] Kwota jest kolumną liczbową.
- [ ] Wartości statusów są kompletne.
- [ ] Istnieją dane testowe.
- [ ] Istnieją widoki według statusów.

## Pytania kontrolne

1. Która kolumna będzie decydować o ścieżce procesu?
2. Która kolumna wskaże osobę zatwierdzającą?
3. Która kolumna będzie aktualizowana przez przepływ?
4. Czy przepływ powinien zmieniać status automatycznie?
5. Jak użytkownik sprawdzi, gdzie znajduje się jego wniosek?

