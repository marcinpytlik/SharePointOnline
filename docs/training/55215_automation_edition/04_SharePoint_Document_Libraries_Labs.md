# 55215 Automation Edition — Laboratoria SharePoint Document Libraries

## Cel pliku

Ten plik zawiera ćwiczenia dotyczące bibliotek dokumentów SharePoint, przygotowane pod automatyzację dokumentów w Power Automate.

---

# Lab 01 — Utworzenie biblioteki „Umowy”

## Cel ćwiczenia

Utworzenie biblioteki dokumentów, która będzie wykorzystywana w procesie zatwierdzania dokumentów.

## Kroki

1. Wejdź do witryny SharePoint.
2. Wybierz **New** / **Nowy**.
3. Wybierz **Document library** / **Biblioteka dokumentów**.
4. Nazwij bibliotekę: `Umowy`.
5. Dodaj opis: `Biblioteka dokumentów używana w procesie akceptacji umów`.
6. Utwórz bibliotekę.

## Weryfikacja

- [ ] Biblioteka istnieje.
- [ ] Biblioteka jest widoczna w witrynie.
- [ ] Można dodać dokument.

---

# Lab 02 — Dodanie metadanych dokumentu

## Cel ćwiczenia

Dodanie metadanych, które będą używane przez użytkowników i Power Automate.

## Kolumny do dodania

| Nazwa | Typ | Wymagana |
|---|---|---|
| Typ dokumentu | Choice | Tak |
| Status dokumentu | Choice | Tak |
| Właściciel dokumentu | Person or Group | Tak |
| Osoba zatwierdzająca | Person or Group | Tak |
| Data decyzji | Date and Time | Nie |
| Komentarz decyzji | Multiple lines of text | Nie |

## Wartości kolumny Typ dokumentu

- Umowa
- Aneks
- Oferta
- Procedura
- Inny

## Wartości kolumny Status dokumentu

- Roboczy
- Do akceptacji
- Zatwierdzony
- Odrzucony
- Archiwalny

## Kroki

1. Otwórz bibliotekę `Umowy`.
2. Dodaj kolumnę `Typ dokumentu`.
3. Dodaj kolumnę `Status dokumentu`.
4. Dodaj kolumnę `Właściciel dokumentu`.
5. Dodaj kolumnę `Osoba zatwierdzająca`.
6. Dodaj kolumnę `Data decyzji`.
7. Dodaj kolumnę `Komentarz decyzji`.

## Weryfikacja

- [ ] Wszystkie kolumny istnieją.
- [ ] Status dokumentu ma poprawne wartości.
- [ ] Typ dokumentu ma poprawne wartości.

---

# Lab 03 — Widoki biblioteki dokumentów

## Cel ćwiczenia

Utworzenie widoków ułatwiających pracę z dokumentami procesowymi.

## Widoki

| Widok | Filtr |
|---|---|
| Do akceptacji | Status dokumentu = Do akceptacji |
| Zatwierdzone | Status dokumentu = Zatwierdzony |
| Odrzucone | Status dokumentu = Odrzucony |
| Robocze | Status dokumentu = Roboczy |

## Kroki

1. Utwórz widok `Do akceptacji`.
2. Ustaw filtr po statusie dokumentu.
3. Utwórz widok `Zatwierdzone`.
4. Utwórz widok `Odrzucone`.
5. Utwórz widok `Robocze`.

## Weryfikacja

- [ ] Widoki istnieją.
- [ ] Widoki filtrują dokumenty.
- [ ] Uczestnik rozumie różnicę między folderami a metadanymi.

---

# Lab 04 — Dodanie przykładowych dokumentów

## Cel ćwiczenia

Dodanie dokumentów testowych do procesu zatwierdzania.

## Dokumenty

Użyj dowolnych plików testowych, na przykład:

- Umowa_testowa_001.docx
- Aneks_testowy_001.docx
- Oferta_dostawcy_001.pdf
- Procedura_zakupowa.docx

## Kroki

1. Wgraj dokument do biblioteki `Umowy`.
2. Uzupełnij metadane.
3. Ustaw `Status dokumentu` na `Do akceptacji`.
4. Wskaż właściciela dokumentu.
5. Wskaż osobę zatwierdzającą.
6. Powtórz dla kilku dokumentów.

## Weryfikacja

- [ ] Dokumenty są widoczne w bibliotece.
- [ ] Dokumenty mają uzupełnione metadane.
- [ ] Dokumenty pojawiają się w odpowiednich widokach.

---

# Lab 05 — Przygotowanie biblioteki pod Power Automate

## Cel ćwiczenia

Sprawdzenie, czy biblioteka dokumentów nadaje się do automatyzacji.

## Checklista

- [ ] Biblioteka ma czytelną nazwę.
- [ ] Dokumenty mają metadane.
- [ ] Status dokumentu jest kolumną typu Choice.
- [ ] Osoba zatwierdzająca jest kolumną typu Person.
- [ ] Istnieją widoki według statusów.
- [ ] Dokumenty testowe mają status `Do akceptacji`.
- [ ] Wiadomo, kto zatwierdza dokument.
- [ ] Wiadomo, gdzie zapisać komentarz decyzji.

## Pytania kontrolne

1. Czy dokument powinien być zatwierdzany po samym dodaniu pliku?
2. Czy zatwierdzanie powinno startować dopiero po zmianie statusu na `Do akceptacji`?
3. Kto jest właścicielem dokumentu?
4. Kto otrzyma informację po decyzji?
5. Czy dokument po zatwierdzeniu powinien być przeniesiony do innej biblioteki?

