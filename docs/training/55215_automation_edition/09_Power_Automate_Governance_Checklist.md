# 55215 Automation Edition — Power Automate Governance Checklist

## Cel checklisty

Ta checklista pomaga tworzyć przepływy Power Automate w sposób uporządkowany, bezpieczny i możliwy do utrzymania po szkoleniu.

---

## 1. Nazewnictwo przepływu

- [ ] Nazwa przepływu opisuje system lub obszar.
- [ ] Nazwa przepływu opisuje proces.
- [ ] Nazwa przepływu opisuje akcję biznesową.
- [ ] Uniknięto nazw typu `Test`, `Flow 1`, `Nowy przepływ`.

### Przykład dobrej nazwy

```text
SPO - Wnioski zakupowe - Proces akceptacji
```

### Przykład złej nazwy

```text
Test flow Marcin 2 final poprawiony
```

---

## 2. Nazewnictwo akcji

- [ ] Trigger ma czytelną nazwę.
- [ ] Warunki mają czytelne nazwy.
- [ ] Akcje Update item mają czytelne nazwy.
- [ ] Akcje e-mail mają czytelne nazwy.
- [ ] Approval ma czytelną nazwę.

### Przykłady

```text
TRIGGER - Nowy wniosek zakupowy
CONDITION - Czy kwota wymaga akceptacji
APPROVAL - Akceptacja przez przełożonego
UPDATE - Status zatwierdzony
EMAIL - Informacja do osoby zgłaszającej
```

---

## 3. Właścicielstwo przepływu

- [ ] Przepływ ma właściciela biznesowego.
- [ ] Przepływ ma współwłaściciela.
- [ ] Wiadomo, kto odpowiada za zmiany.
- [ ] Wiadomo, kto reaguje na błędy.
- [ ] Konto autora przepływu nie jest jedynym właścicielem.

### Ryzyko

Jeżeli przepływ ma tylko jednego właściciela i ta osoba odejdzie z organizacji, proces może stać się trudny do utrzymania.

---

## 4. Połączenia i konta

- [ ] Wiadomo, na czyich połączeniach działa przepływ.
- [ ] Sprawdzono połączenie SharePoint.
- [ ] Sprawdzono połączenie Outlook.
- [ ] Sprawdzono połączenie Approvals.
- [ ] Rozważono użycie konta technicznego dla procesów krytycznych.

---

## 5. Dokumentacja procesu

- [ ] Opisano cel przepływu.
- [ ] Opisano źródłową listę lub bibliotekę.
- [ ] Opisano warunek biznesowy.
- [ ] Opisano osoby zatwierdzające.
- [ ] Opisano aktualizowane kolumny.
- [ ] Opisano wiadomości wysyłane przez przepływ.
- [ ] Opisano sposób testowania.
- [ ] Opisano procedurę awaryjną.

---

## 6. Testowanie

- [ ] Przetestowano ścieżkę pozytywną.
- [ ] Przetestowano ścieżkę negatywną.
- [ ] Przetestowano brak wymaganych danych.
- [ ] Przetestowano różne kwoty.
- [ ] Przetestowano różne osoby zatwierdzające.
- [ ] Sprawdzono wiadomości e-mail.
- [ ] Sprawdzono historię uruchomień.

---

## 7. Zmiany w SharePoint

Przed zmianą listy lub biblioteki sprawdź:

- [ ] Czy kolumna jest używana w przepływie?
- [ ] Czy zmiana typu kolumny zepsuje warunek?
- [ ] Czy usunięcie wartości Choice zepsuje aktualizację statusu?
- [ ] Czy zmiana nazwy kolumny wymaga poprawki przepływu?
- [ ] Czy przepływ trzeba przetestować po zmianie?

---

## 8. Limity i wydajność

- [ ] Przepływ nie uruchamia się niepotrzebnie zbyt często.
- [ ] Przepływ nie tworzy pętli.
- [ ] Przepływ nie aktualizuje elementu bez potrzeby.
- [ ] Przepływ nie pobiera zbyt wielu elementów bez filtrowania.
- [ ] Dla większych list zaplanowano filtrowanie.
- [ ] Dla krytycznych procesów zaplanowano monitoring.

---

## 9. Kiedy eskalować do IT

Przekaż temat do IT lub zespołu technicznego, gdy:

- proces jest krytyczny biznesowo,
- wymaga integracji z systemem zewnętrznym,
- wymaga kont technicznych,
- wymaga niestandardowych konektorów,
- przetwarza dane wrażliwe,
- wymaga silnego audytu,
- ma bardzo dużą liczbę uruchomień,
- ma zastąpić formalny system obiegu dokumentów.

---

## 10. Checklista końcowa przed wdrożeniem

- [ ] Przepływ ma poprawną nazwę.
- [ ] Akcje mają czytelne nazwy.
- [ ] Przepływ ma właściciela i współwłaściciela.
- [ ] Połączenia są sprawdzone.
- [ ] Lista lub biblioteka jest stabilna.
- [ ] Statusy procesu są opisane.
- [ ] Ścieżka Approved działa.
- [ ] Ścieżka Rejected działa.
- [ ] Obsłużono brak danych.
- [ ] Wiadomości e-mail są czytelne.
- [ ] Historia uruchomień została sprawdzona.
- [ ] Proces jest udokumentowany.
- [ ] Użytkownicy wiedzą, gdzie zgłaszać błędy.

