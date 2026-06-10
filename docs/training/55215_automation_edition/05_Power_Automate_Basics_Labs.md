# 55215 Automation Edition — Power Automate Basics Labs

## Cel pliku

Ten plik zawiera pierwsze laboratoria Power Automate oparte o SharePoint Online.

---

# Lab 01 — Pierwszy przepływ SharePoint → e-mail

## Cel ćwiczenia

Utworzenie pierwszego przepływu, który reaguje na dodanie elementu do listy SharePoint i wysyła powiadomienie e-mail.

## Scenariusz

Po dodaniu nowego wniosku zakupowego system wysyła wiadomość do osoby zatwierdzającej.

## Wymagania

- Lista `Wnioski zakupowe` istnieje.
- Lista ma kolumnę `Osoba zatwierdzająca`.
- Lista ma kolumnę `Kwota`.
- Uczestnik ma dostęp do Power Automate.

## Kroki

1. Otwórz Power Automate.
2. Wybierz **Create**.
3. Wybierz **Automated cloud flow**.
4. Nazwij przepływ: `SPO - Wnioski zakupowe - Powiadomienie o nowym wniosku`.
5. Wybierz trigger SharePoint: `When an item is created`.
6. Wskaż adres witryny.
7. Wskaż listę `Wnioski zakupowe`.
8. Dodaj akcję `Send an email` albo `Send an email (V2)`.
9. W polu odbiorcy wybierz dynamiczną wartość z kolumny `Osoba zatwierdzająca`.
10. W temacie wpisz: `Nowy wniosek zakupowy: [Title]`.
11. W treści dodaj:
    - tytuł wniosku,
    - kwotę,
    - osobę zgłaszającą,
    - link do elementu.
12. Zapisz przepływ.
13. Dodaj nowy element do listy.
14. Sprawdź, czy wiadomość została wysłana.

## Przykładowa treść wiadomości

```text
Dzień dobry,

utworzono nowy wniosek zakupowy.

Tytuł: [Title]
Kwota: [Kwota]
Osoba zgłaszająca: [Osoba zgłaszająca]

Proszę o weryfikację wniosku w SharePoint.
```

## Weryfikacja

- [ ] Przepływ został zapisany.
- [ ] Przepływ uruchamia się po dodaniu elementu.
- [ ] Wiadomość dociera do osoby zatwierdzającej.
- [ ] Historia uruchomienia pokazuje status sukcesu.

---

# Lab 02 — Aktualizacja statusu po utworzeniu elementu

## Cel ćwiczenia

Dodanie akcji aktualizującej status nowego elementu.

## Scenariusz

Po dodaniu wniosku status automatycznie zmienia się z `Nowy` na `W trakcie akceptacji`.

## Kroki

1. Otwórz przepływ utworzony w poprzednim ćwiczeniu.
2. Dodaj akcję SharePoint `Update item`.
3. Wskaż tę samą witrynę i listę.
4. Wskaż ID elementu z triggera.
5. Wypełnij wymagane pola listy.
6. W kolumnie `Status` ustaw wartość `W trakcie akceptacji`.
7. Zapisz przepływ.
8. Dodaj nowy wniosek.
9. Sprawdź, czy status został zmieniony.

## Weryfikacja

- [ ] Status elementu zmienia się automatycznie.
- [ ] Przepływ nie kasuje innych danych.
- [ ] Wymagane kolumny są prawidłowo przekazywane do akcji Update item.

---

# Lab 03 — Warunek na podstawie kwoty

## Cel ćwiczenia

Dodanie logiki decyzyjnej do przepływu.

## Scenariusz

- Wnioski do 1000 zł są zatwierdzane automatycznie.
- Wnioski powyżej 1000 zł wymagają akceptacji.

## Kroki

1. Otwórz przepływ.
2. Dodaj akcję `Condition`.
3. Ustaw warunek:
   - `Kwota` is less than or equal to `1000`.
4. W gałęzi `If yes` dodaj `Update item`.
5. Ustaw `Status` na `Zatwierdzony`.
6. Dodaj wiadomość e-mail do osoby zgłaszającej.
7. W gałęzi `If no` ustaw `Status` na `W trakcie akceptacji`.
8. Dodaj wiadomość e-mail do osoby zatwierdzającej.
9. Zapisz przepływ.
10. Przetestuj przepływ dla kwoty 500.
11. Przetestuj przepływ dla kwoty 2500.

## Weryfikacja

- [ ] Kwota 500 przechodzi ścieżką automatyczną.
- [ ] Kwota 2500 przechodzi ścieżką wymagającą akceptacji.
- [ ] Statusy są aktualizowane poprawnie.
- [ ] Wiadomości trafiają do właściwych osób.

---

# Lab 04 — Użycie Compose i czytelne nazwy akcji

## Cel ćwiczenia

Poprawa czytelności przepływu.

## Kroki

1. Otwórz przepływ.
2. Zmień nazwy akcji na czytelne, np.:
   - `TRIGGER - Nowy wniosek zakupowy`,
   - `CONDITION - Czy kwota <= 1000`,
   - `UPDATE - Status Zatwierdzony`,
   - `EMAIL - Informacja do zgłaszającego`.
3. Dodaj akcję `Compose` z krótkim podsumowaniem wniosku.
4. Użyj wyniku Compose w wiadomości e-mail.
5. Zapisz i przetestuj przepływ.

## Weryfikacja

- [ ] Nazwy akcji są czytelne.
- [ ] Przepływ jest łatwiejszy do omówienia.
- [ ] Compose działa poprawnie.

---

# Lab 05 — Historia uruchomień

## Cel ćwiczenia

Nauczenie uczestnika podstawowej diagnostyki przepływu.

## Kroki

1. Otwórz Power Automate.
2. Wejdź w listę przepływów.
3. Otwórz swój przepływ.
4. Przejdź do historii uruchomień.
5. Otwórz ostatnie uruchomienie.
6. Sprawdź trigger.
7. Sprawdź każdą akcję.
8. Zobacz wejścia i wyjścia akcji.
9. Sprawdź, która gałąź warunku została wykonana.

## Weryfikacja

- [ ] Uczestnik potrafi znaleźć historię uruchomienia.
- [ ] Uczestnik potrafi sprawdzić, która akcja się wykonała.
- [ ] Uczestnik potrafi odczytać błąd lub sukces.

