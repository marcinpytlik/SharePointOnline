# 55215 Automation Edition — Notatki trenerskie

## Cel dokumentu

Ten dokument zawiera wskazówki dla trenera prowadzącego zmodyfikowaną wersję kursu 55215 SharePoint Online Power User z mocnym blokiem Power Automate.

---

## Charakter grupy

Ta grupa jest bardziej nastawiona na automatyzację niż wcześniejsze grupy administracyjne. Dlatego tempo i akcenty powinny być inne.

### Mniej czasu na

- szczegóły administracyjne tenantowe,
- zaawansowane uprawnienia,
- głęboką teorię SharePoint,
- pełne governance Microsoft 365,
- dyskusje o strukturze całej organizacji.

### Więcej czasu na

- listy jako źródła danych,
- statusy procesu,
- metadane,
- biblioteki dokumentów jako element procesu,
- Power Automate,
- approval,
- troubleshooting,
- dobre praktyki utrzymania przepływów.

---

## Główna narracja kursu

Powtarzaj uczestnikom:

> SharePoint jest fundamentem danych i dokumentów.  
> Power Automate jest warstwą procesu.  
> Jeżeli lista jest źle zaprojektowana, przepływ będzie trudny do utrzymania.

---

## Proponowany sposób prowadzenia

### Dzień 1

Cel: oswoić grupę ze środowiskiem SharePoint, ale nie przeładować administracją.

Akcenty:

- czym jest witryna,
- gdzie są dokumenty,
- gdzie są listy,
- jak wygląda strona,
- co użytkownik może zrobić samodzielnie.

Unikaj zbyt długiego omawiania:

- hub sites,
- globalnej architektury intranetu,
- głębokich ról administracyjnych.

### Dzień 2

Cel: przygotować grunt pod Power Automate.

Akcenty:

- lista to nie Excel,
- status procesu jest kluczowy,
- osoba zatwierdzająca musi być kolumną Person,
- kwota musi być liczbą,
- widoki pomagają kontrolować proces,
- biblioteka dokumentów bez metadanych jest trudna do automatyzacji.

Najważniejsze pytanie dnia:

> Czy ta lista jest gotowa do automatyzacji?

### Dzień 3

Cel: pełny dzień automatyzacji.

Akcenty:

- trigger,
- dynamic content,
- update item,
- condition,
- approval,
- historia uruchomień.

Nie pędź. Lepiej zrobić mniej przepływów, ale dobrze wyjaśnić diagnostykę.

### Dzień 4

Cel: domknąć proces i pokazać utrzymanie.

Akcenty:

- projekt końcowy,
- troubleshooting,
- nazewnictwo,
- właściciele,
- dokumentacja,
- kiedy przekazać temat do IT.

---

## Najważniejsze ryzyka podczas kursu

### 1. Uczestnicy źle przygotują listę

Objaw:

- kolumna Kwota jest tekstem,
- Status nie jest Choice,
- osoba zatwierdzająca jest tekstem,
- brak wymaganych danych.

Reakcja:

- zatrzymać grupę,
- poprawić strukturę,
- wyjaśnić, że Power Automate zależy od jakości danych.

### 2. Update item sprawia problemy

Objaw:

- akcja wymaga wielu pól,
- status nie zapisuje się,
- dane są czyszczone.

Reakcja:

- pokazać wymagane kolumny,
- wyjaśnić mapowanie pól,
- przypomnieć o testowaniu po każdej zmianie.

### 3. Approval nie dochodzi

Objaw:

- osoba zatwierdzająca nie widzi approval,
- flow czeka.

Reakcja:

- sprawdzić kolumnę Person,
- sprawdzić adres e-mail,
- sprawdzić centrum Approval,
- sprawdzić historię uruchomień.

### 4. Flow uruchamia się wiele razy

Objaw:

- przepływ sam się zapętla,
- po update item uruchamia się ponownie.

Reakcja:

- omówić różnicę triggerów created vs modified,
- dodać warunek statusu,
- pokazać zabezpieczenie przed pętlą.

---

## Minimalny projekt, który musi zadziałać

Jeżeli zabraknie czasu, doprowadź grupę przynajmniej do tego wariantu:

1. Lista `Wnioski zakupowe`.
2. Kolumny: Title, Kwota, Osoba zatwierdzająca, Status.
3. Flow po dodaniu elementu.
4. Warunek kwotowy.
5. Dla kwoty <= 1000: status `Zatwierdzony`.
6. Dla kwoty > 1000: approval.
7. Po approval: status `Zatwierdzony` albo `Odrzucony`.
8. E-mail do osoby zgłaszającej.
9. Analiza historii uruchomienia.

---

## Pytania do dyskusji z grupą

1. Jakie procesy w Waszej organizacji nadal działają przez e-mail?
2. Które z nich można przenieść na listę SharePoint?
3. Jakie statusy powinien mieć taki proces?
4. Kto powinien zatwierdzać?
5. Czy decyzja zależy od kwoty, działu, typu dokumentu lub priorytetu?
6. Jak użytkownik powinien wiedzieć, na jakim etapie jest sprawa?
7. Kto będzie właścicielem przepływu po wdrożeniu?
8. Co się stanie, gdy przepływ przestanie działać?

---

## Gotowe przykłady procesów do omówienia

- wniosek zakupowy,
- wniosek urlopowy,
- akceptacja faktury,
- obieg umowy,
- rejestr zgłoszeń IT,
- rejestr spraw administracyjnych,
- akceptacja publikacji dokumentu,
- zgłoszenie potrzeby szkoleniowej,
- zgłoszenie zapotrzebowania sprzętowego.

---

## Słowa-klucze, które warto powtarzać

- lista jako rejestr,
- biblioteka jako repozytorium dokumentów,
- metadane zamiast folderów,
- status procesu,
- osoba zatwierdzająca,
- trigger,
- akcja,
- warunek,
- approval,
- historia uruchomień,
- właściciel przepływu,
- dokumentacja procesu.

---

## Zakończenie kursu

Na końcu warto powiedzieć:

> Po tym kursie nie chodzi o to, żeby każdy uczestnik stał się administratorem Microsoft 365.  
> Chodzi o to, żeby umiał rozpoznać proces, przygotować dla niego dobrą listę lub bibliotekę SharePoint i zbudować prostą, utrzymywalną automatyzację w Power Automate.

