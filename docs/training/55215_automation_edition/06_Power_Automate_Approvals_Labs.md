# 55215 Automation Edition — Power Automate Approvals Labs

## Cel pliku

Ten plik zawiera laboratoria dotyczące zatwierdzania wniosków i dokumentów z użyciem Power Automate Approvals.

---

# Lab 01 — Approval dla wniosku zakupowego

## Cel ćwiczenia

Utworzenie procesu zatwierdzania dla wniosku zakupowego.

## Scenariusz

Jeśli kwota wniosku przekracza 1000 zł, system wysyła approval do osoby zatwierdzającej. Po decyzji aktualizuje status wniosku i wysyła informację do osoby zgłaszającej.

## Wymagania

- Lista `Wnioski zakupowe` istnieje.
- Lista ma kolumnę `Osoba zatwierdzająca`.
- Lista ma kolumnę `Status`.
- Lista ma kolumnę `Data decyzji`.
- Lista ma kolumnę `Komentarz decyzji`.

## Kroki

1. Otwórz przepływ z warunkiem kwotowym.
2. W gałęzi dla kwoty powyżej 1000 dodaj akcję `Start and wait for an approval`.
3. Wybierz typ approval: `Approve/Reject - First to respond`.
4. Tytuł approval ustaw na: `Akceptacja wniosku zakupowego: [Title]`.
5. W polu Assigned to wskaż osobę z kolumny `Osoba zatwierdzająca`.
6. W szczegółach approval dodaj:
   - tytuł,
   - kwotę,
   - uzasadnienie,
   - osobę zgłaszającą.
7. Po approval dodaj warunek sprawdzający wynik decyzji.
8. Jeśli wynik to `Approve`, ustaw status `Zatwierdzony`.
9. Jeśli wynik to `Reject`, ustaw status `Odrzucony`.
10. W obu gałęziach zapisz datę decyzji.
11. W obu gałęziach zapisz komentarz decyzji.
12. Wyślij informację do osoby zgłaszającej.
13. Zapisz przepływ.
14. Przetestuj decyzję pozytywną.
15. Przetestuj decyzję negatywną.

## Weryfikacja

- [ ] Approval trafia do osoby zatwierdzającej.
- [ ] Decyzja Approved ustawia status `Zatwierdzony`.
- [ ] Decyzja Rejected ustawia status `Odrzucony`.
- [ ] Komentarz decyzji zapisuje się na liście.
- [ ] Osoba zgłaszająca dostaje wiadomość.

---

# Lab 02 — Approval dla dokumentu w bibliotece „Umowy”

## Cel ćwiczenia

Utworzenie procesu zatwierdzania dokumentu dodanego do biblioteki.

## Scenariusz

Po dodaniu dokumentu i ustawieniu statusu `Do akceptacji` system uruchamia approval do osoby zatwierdzającej.

## Wymagania

- Biblioteka `Umowy` istnieje.
- Biblioteka ma kolumnę `Status dokumentu`.
- Biblioteka ma kolumnę `Osoba zatwierdzająca`.
- Biblioteka ma kolumnę `Data decyzji`.
- Biblioteka ma kolumnę `Komentarz decyzji`.

## Kroki

1. Utwórz nowy automated cloud flow.
2. Nazwij przepływ: `SPO - Umowy - Approval dokumentu`.
3. Wybierz trigger SharePoint dla pliku utworzonego w bibliotece.
4. Wskaż witrynę i bibliotekę `Umowy`.
5. Dodaj warunek: `Status dokumentu` równa się `Do akceptacji`.
6. W gałęzi `If yes` dodaj approval.
7. W approval wskaż osobę zatwierdzającą z metadanych dokumentu.
8. Dodaj link do dokumentu w treści approval.
9. Po approval dodaj warunek na wynik decyzji.
10. Jeśli Approved, ustaw `Status dokumentu` na `Zatwierdzony`.
11. Jeśli Rejected, ustaw `Status dokumentu` na `Odrzucony`.
12. Zapisz komentarz decyzji.
13. Wyślij wiadomość do właściciela dokumentu.
14. Zapisz i przetestuj przepływ.

## Weryfikacja

- [ ] Dodanie dokumentu uruchamia przepływ.
- [ ] Approval zawiera link do dokumentu.
- [ ] Status dokumentu zmienia się po decyzji.
- [ ] Właściciel dokumentu otrzymuje informację.

---

# Lab 03 — Obsługa odrzucenia i status „Do uzupełnienia”

## Cel ćwiczenia

Rozbudowanie procesu o bardziej realistyczną ścieżkę odrzucenia.

## Scenariusz

Jeżeli osoba zatwierdzająca odrzuci wniosek lub dokument, status ma zostać ustawiony na `Do uzupełnienia`, a nie od razu na końcowe `Odrzucony`.

## Kroki

1. Otwórz przepływ approval.
2. Znajdź gałąź `Rejected`.
3. Zmień aktualizację statusu z `Odrzucony` na `Do uzupełnienia`.
4. W wiadomości do autora dodaj komentarz decyzji.
5. Dodaj informację: `Uzupełnij dane i ponownie zgłoś do akceptacji`.
6. Zapisz przepływ.
7. Przetestuj odrzucenie.

## Weryfikacja

- [ ] Odrzucenie ustawia status `Do uzupełnienia`.
- [ ] Komentarz decyzji jest zapisany.
- [ ] Autor wie, co ma poprawić.

---

# Lab 04 — Rejestr decyzji

## Cel ćwiczenia

Zapisanie każdej decyzji approval do osobnej listy historii.

## Lista pomocnicza

Utwórz listę `Rejestr decyzji` z kolumnami:

| Kolumna | Typ |
|---|---|
| Title | Tekst |
| Typ procesu | Choice |
| ID elementu źródłowego | Number |
| Decyzja | Choice |
| Osoba decyzyjna | Person |
| Data decyzji | Date and Time |
| Komentarz | Multiple lines of text |

## Kroki

1. Utwórz listę `Rejestr decyzji`.
2. Otwórz przepływ approval.
3. Po decyzji dodaj akcję `Create item`.
4. Wskaż listę `Rejestr decyzji`.
5. Zapisz:
   - tytuł wniosku,
   - typ procesu,
   - ID elementu,
   - decyzję,
   - osobę decyzyjną,
   - komentarz.
6. Zapisz i przetestuj przepływ.

## Weryfikacja

- [ ] Każda decyzja tworzy wpis w rejestrze.
- [ ] Rejestr zawiera decyzję i komentarz.
- [ ] Można odtworzyć historię procesu.

