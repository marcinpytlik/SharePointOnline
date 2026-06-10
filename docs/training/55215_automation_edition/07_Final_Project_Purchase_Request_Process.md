# 55215 Automation Edition — Projekt końcowy

## Nazwa projektu

**Automatyzacja obsługi wniosków zakupowych w SharePoint Online**

---

## Cel projektu

Celem projektu jest zbudowanie kompletnego, prostego procesu biznesowego z użyciem SharePoint Online i Power Automate.

Uczestnik kończy kurs z gotowym wzorcem, który może później przenieść na inne procesy:

- wnioski urlopowe,
- akceptacja faktur,
- obieg umów,
- rejestr zgłoszeń,
- proces zakupowy,
- proces administracyjny,
- proces HR.

---

## Scenariusz biznesowy

Organizacja chce uporządkować proces obsługi wniosków zakupowych. Obecnie wnioski są wysyłane e-mailem, przez co trudno ustalić:

- kto zgłosił wniosek,
- jaka jest kwota,
- kto zatwierdza,
- jaki jest status,
- kiedy zapadła decyzja,
- jaki był komentarz osoby zatwierdzającej.

Nowe rozwiązanie ma wykorzystywać:

- SharePoint Online jako rejestr wniosków,
- bibliotekę dokumentów jako miejsce przechowywania załączników,
- Power Automate jako mechanizm automatyzacji i zatwierdzania.

---

## Zakres projektu

Projekt obejmuje:

1. Witrynę SharePoint `Zakupy`.
2. Listę `Wnioski zakupowe`.
3. Bibliotekę `Dokumenty zakupowe`.
4. Widoki według statusów.
5. Przepływ Power Automate uruchamiany po dodaniu wniosku.
6. Warunek kwotowy.
7. Approval dla wniosków powyżej 1000 zł.
8. Automatyczne zatwierdzanie wniosków do 1000 zł.
9. Aktualizację statusów.
10. Zapis komentarza decyzji.
11. Powiadomienia e-mail.
12. Rejestr decyzji.
13. Diagnostykę działania.
14. Dokumentację przepływu.

---

## Etap 1 — Przygotowanie witryny

### Zadania

1. Utwórz lub wykorzystaj witrynę SharePoint.
2. Nazwij ją `Zakupy` albo użyj witryny szkoleniowej.
3. Dodaj stronę startową opisującą proces.
4. Dodaj linki do listy i biblioteki.

### Weryfikacja

- [ ] Witryna istnieje.
- [ ] Uczestnik ma do niej dostęp.
- [ ] Strona startowa zawiera opis procesu.
- [ ] Linki do listy i biblioteki są widoczne.

---

## Etap 2 — Lista „Wnioski zakupowe”

### Kolumny

| Nazwa | Typ | Wymagana |
|---|---|---|
| Title | Tekst | Tak |
| Kwota | Number/Currency | Tak |
| Uzasadnienie | Multiple lines of text | Nie |
| Osoba zgłaszająca | Person | Tak |
| Osoba zatwierdzająca | Person | Tak |
| Status | Choice | Tak |
| Data decyzji | Date and Time | Nie |
| Komentarz decyzji | Multiple lines of text | Nie |
| Priorytet | Choice | Nie |

### Statusy

- Nowy
- W trakcie akceptacji
- Zatwierdzony
- Odrzucony
- Do uzupełnienia
- Zamknięty

### Widoki

- Nowe wnioski
- W trakcie akceptacji
- Zatwierdzone
- Odrzucone
- Wszystkie aktywne

### Weryfikacja

- [ ] Lista ma wymagane kolumny.
- [ ] Status jest typu Choice.
- [ ] Osoba zatwierdzająca jest typu Person.
- [ ] Widoki działają.

---

## Etap 3 — Biblioteka „Dokumenty zakupowe”

### Kolumny

| Nazwa | Typ |
|---|---|
| Typ dokumentu | Choice |
| Status dokumentu | Choice |
| Właściciel dokumentu | Person |
| Powiązany wniosek | Hyperlink albo tekst |
| Data decyzji | Date and Time |
| Komentarz decyzji | Multiple lines of text |

### Weryfikacja

- [ ] Biblioteka istnieje.
- [ ] Można dodawać dokumenty.
- [ ] Dokumenty mają metadane.

---

## Etap 4 — Przepływ Power Automate

### Nazwa przepływu

`SPO - Wnioski zakupowe - Proces akceptacji`

### Logika przepływu

```text
Trigger:
When an item is created

Krok 1:
Sprawdź kwotę wniosku

Jeśli Kwota <= 1000:
    Ustaw Status = Zatwierdzony
    Ustaw Data decyzji = teraz
    Ustaw Komentarz decyzji = Zatwierdzone automatycznie
    Wyślij e-mail do osoby zgłaszającej
    Dodaj wpis do Rejestru decyzji

Jeśli Kwota > 1000:
    Ustaw Status = W trakcie akceptacji
    Uruchom Approval do osoby zatwierdzającej

    Jeśli Approved:
        Ustaw Status = Zatwierdzony
        Ustaw Data decyzji = teraz
        Zapisz komentarz decyzji
        Wyślij e-mail do osoby zgłaszającej
        Dodaj wpis do Rejestru decyzji

    Jeśli Rejected:
        Ustaw Status = Do uzupełnienia albo Odrzucony
        Ustaw Data decyzji = teraz
        Zapisz komentarz decyzji
        Wyślij e-mail do osoby zgłaszającej
        Dodaj wpis do Rejestru decyzji
```

---

## Etap 5 — Testy procesu

### Scenariusz testowy 1 — wniosek do 1000 zł

| Krok | Oczekiwany rezultat |
|---|---|
| Dodaj wniosek na 300 zł | Przepływ uruchamia się |
| Kwota <= 1000 | Approval nie jest wymagany |
| Status | Zatwierdzony |
| E-mail | Osoba zgłaszająca dostaje informację |
| Rejestr decyzji | Powstaje wpis |

### Scenariusz testowy 2 — wniosek powyżej 1000 zł, Approved

| Krok | Oczekiwany rezultat |
|---|---|
| Dodaj wniosek na 2500 zł | Przepływ uruchamia się |
| Kwota > 1000 | Approval jest wysłany |
| Decyzja | Approved |
| Status | Zatwierdzony |
| Komentarz | Zapisany na liście |
| E-mail | Osoba zgłaszająca dostaje informację |

### Scenariusz testowy 3 — wniosek powyżej 1000 zł, Rejected

| Krok | Oczekiwany rezultat |
|---|---|
| Dodaj wniosek na 5000 zł | Przepływ uruchamia się |
| Kwota > 1000 | Approval jest wysłany |
| Decyzja | Rejected |
| Status | Do uzupełnienia albo Odrzucony |
| Komentarz | Zapisany na liście |
| E-mail | Osoba zgłaszająca dostaje informację |

---

## Etap 6 — Dokumentacja przepływu

Dla przepływu należy opisać:

- nazwę przepływu,
- właściciela,
- współwłaściciela,
- listę źródłową,
- warunek biznesowy,
- osobę zatwierdzającą,
- aktualizowane kolumny,
- wysyłane wiadomości,
- możliwe błędy,
- sposób testowania.

### Szablon dokumentacji

| Pole | Wartość |
|---|---|
| Nazwa przepływu | |
| Cel przepływu | |
| Właściciel | |
| Współwłaściciel | |
| Lista źródłowa | |
| Biblioteka źródłowa | |
| Trigger | |
| Warunek główny | |
| Akcje aktualizacji | |
| Akcje e-mail | |
| Approval | |
| Krytyczne kolumny | |
| Znane ograniczenia | |
| Data ostatniego testu | |

---

## Kryteria zaliczenia projektu

- [ ] Lista SharePoint jest przygotowana poprawnie.
- [ ] Biblioteka dokumentów jest przygotowana poprawnie.
- [ ] Widoki według statusów działają.
- [ ] Przepływ uruchamia się po dodaniu wniosku.
- [ ] Warunek kwotowy działa.
- [ ] Approval działa dla kwot powyżej 1000 zł.
- [ ] Statusy są aktualizowane.
- [ ] Komentarz decyzji jest zapisywany.
- [ ] Osoba zgłaszająca dostaje wiadomość.
- [ ] Historia uruchomień została sprawdzona.
- [ ] Przepływ jest udokumentowany.

