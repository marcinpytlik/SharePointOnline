# 55215 Automation Edition — Power Automate Troubleshooting Checklist

## Cel checklisty

Ta checklista pomaga diagnozować najczęstsze problemy z przepływami Power Automate opartymi o SharePoint Online.

---

## 1. Czy przepływ się uruchomił?

- [ ] Sprawdzono historię uruchomień przepływu.
- [ ] Sprawdzono, czy pojawił się nowy run.
- [ ] Sprawdzono, czy trigger jest poprawny.
- [ ] Sprawdzono, czy lista lub biblioteka jest właściwa.
- [ ] Sprawdzono, czy element spełnia warunki triggera.

### Typowe przyczyny

| Objaw | Możliwa przyczyna |
|---|---|
| Brak uruchomienia | błędna lista lub biblioteka |
| Brak uruchomienia | przepływ jest wyłączony |
| Brak uruchomienia | element został tylko zmodyfikowany, a trigger reaguje na utworzenie |
| Brak uruchomienia | polityka organizacji blokuje przepływ |

---

## 2. Czy trigger wskazuje właściwe źródło?

- [ ] Adres witryny jest poprawny.
- [ ] Nazwa listy jest poprawna.
- [ ] Nazwa biblioteki jest poprawna.
- [ ] Użytkownik ma dostęp do źródła.
- [ ] Połączenie SharePoint działa.

---

## 3. Czy akcja Update item działa poprawnie?

- [ ] Przekazano poprawne ID elementu.
- [ ] Wypełniono wszystkie wymagane pola.
- [ ] Nie pominięto kolumn wymaganych przez listę.
- [ ] Status ma wartość zgodną z kolumną Choice.
- [ ] Kolumna Person otrzymuje poprawną wartość.

### Typowy błąd

Akcja Update item może wymagać podania wartości dla kolumn, które nie są bezpośrednio zmieniane. Jeżeli lista ma kolumny wymagane, trzeba uważać, aby aktualizacja nie wyczyściła danych lub nie zakończyła się błędem.

---

## 4. Czy warunek działa poprawnie?

- [ ] Sprawdzono wartość wejściową warunku.
- [ ] Sprawdzono typ danych.
- [ ] Kwota jest liczbą, a nie tekstem.
- [ ] Porównanie używa właściwego operatora.
- [ ] Przetestowano obie ścieżki: If yes i If no.

### Przykład

Warunek:

```text
Kwota <= 1000
```

Testy:

- kwota 500 — powinna przejść ścieżką automatyczną,
- kwota 2500 — powinna przejść ścieżką approval.

---

## 5. Czy Approval działa poprawnie?

- [ ] Wskazano osobę zatwierdzającą.
- [ ] Osoba zatwierdzająca ma poprawny adres e-mail.
- [ ] Approval jest widoczny w Power Automate.
- [ ] Approval jest widoczny w Outlook lub Teams.
- [ ] Przepływ czeka na decyzję.
- [ ] Po decyzji przepływ przechodzi dalej.

### Typowe problemy

| Objaw | Możliwa przyczyna |
|---|---|
| Approval nie dochodzi | błędna osoba zatwierdzająca |
| Approval nie dochodzi | brak adresu e-mail w kolumnie Person |
| Flow czeka bez końca | nikt nie podjął decyzji |
| Flow nie idzie dalej | błąd w warunku po approval |

---

## 6. Czy e-mail został wysłany?

- [ ] Akcja e-mail zakończyła się sukcesem.
- [ ] Odbiorca jest poprawny.
- [ ] Wiadomość nie trafiła do spamu.
- [ ] Użyto właściwego konektora Outlook.
- [ ] Konto ma możliwość wysyłki.

---

## 7. Czy przepływ nie uruchamia sam siebie?

- [ ] Sprawdzono, czy trigger reaguje na modyfikację elementu.
- [ ] Sprawdzono, czy Update item nie powoduje ponownego uruchomienia.
- [ ] Dodano warunek ograniczający ponowne uruchomienie.
- [ ] Status procesu zapobiega pętli.

### Przykład zabezpieczenia

Przepływ może działać tylko wtedy, gdy status = `Nowy`.

---

## 8. Czy zmieniono listę po utworzeniu przepływu?

- [ ] Sprawdzono, czy kolumny nadal istnieją.
- [ ] Sprawdzono, czy zmieniono nazwę kolumny.
- [ ] Sprawdzono, czy zmieniono typ kolumny.
- [ ] Sprawdzono, czy usunięto wartość Choice.
- [ ] Odświeżono dynamic content w akcjach.

---

## 9. Analiza historii uruchomienia

Dla błędnego uruchomienia sprawdź:

- [ ] która akcja ma status failed,
- [ ] jaki jest komunikat błędu,
- [ ] jakie były wejścia akcji,
- [ ] jakie były wyjścia akcji,
- [ ] czy poprzednia akcja zwróciła oczekiwane dane,
- [ ] czy dana wartość nie była pusta.

---

## 10. Minimalna procedura diagnostyczna

1. Otwórz przepływ.
2. Wejdź w historię uruchomień.
3. Znajdź błędny run.
4. Otwórz pierwszą akcję ze statusem failed.
5. Przeczytaj komunikat błędu.
6. Sprawdź wejścia akcji.
7. Sprawdź, czy wartości dynamiczne nie są puste.
8. Popraw konfigurację.
9. Zapisz przepływ.
10. Uruchom test ponownie.

---

## Szybka checklista trenera

- [ ] Uczestnik umie znaleźć historię uruchomienia.
- [ ] Uczestnik rozumie statusy succeeded, failed, skipped.
- [ ] Uczestnik potrafi wskazać akcję, która się wywaliła.
- [ ] Uczestnik potrafi odczytać komunikat błędu.
- [ ] Uczestnik wie, że zmiana kolumn SharePoint może zepsuć przepływ.
- [ ] Uczestnik wie, że przepływ potrzebuje właściciela i współwłaściciela.

