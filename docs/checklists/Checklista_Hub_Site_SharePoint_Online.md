# Checklista tworzenia Hub Site w SharePoint Online

## Cel dokumentu

Ta checklista pomaga zaplanować, utworzyć i utrzymywać **Hub Site** w SharePoint Online.

Hub Site służy do logicznego łączenia powiązanych witryn, wspólnej nawigacji, spójnego wyglądu oraz agregowania treści, takich jak aktualności, wydarzenia i dokumenty.

---

# 1. Decyzja: czy potrzebujemy Hub Site?

| Pytanie kontrolne | Tak/Nie | Uwagi |
|---|---:|---|
| Czy mamy kilka powiązanych witryn, które powinny tworzyć jeden obszar portalu? |  |  |
| Czy potrzebujemy wspólnej nawigacji dla wielu witryn? |  |  |
| Czy użytkownicy mają łatwo przechodzić między witrynami działu, projektu lub obszaru biznesowego? |  |  |
| Czy chcemy agregować aktualności z powiązanych witryn? |  |  |
| Czy chcemy agregować wydarzenia, linki lub wyróżnione treści? |  |  |
| Czy potrzebujemy spójnego wyglądu dla grupy witryn? |  |  |
| Czy pojedyncza witryna komunikacyjna nie wystarczy? |  |  |
| Czy chcemy uniknąć klasycznej struktury podwitryn? |  |  |
| Czy obszar będzie rozwijany o kolejne witryny w przyszłości? |  |  |

## Decyzja

Jeżeli potrzebujesz tylko jednej witryny informacyjnej, wystarczy **witryna komunikacyjna**.

Jeżeli masz grupę powiązanych witryn, wspólną nawigację i potrzebę agregowania treści, wtedy **Hub Site** ma sens.

---

# 2. Typowe scenariusze dla Hub Site

| Scenariusz | Czy Hub Site ma sens? |
|---|---:|
| Portal HR z osobnymi witrynami: benefity, onboarding, procedury, szkolenia | Tak |
| Portal IT z osobnymi witrynami: helpdesk, procedury, status usług, bezpieczeństwo | Tak |
| Portal projektu strategicznego z wieloma zespołami | Tak |
| Portal oddziału firmy z lokalnymi witrynami | Tak |
| Intranet główny z działami jako powiązanymi hubami lub witrynami | Tak |
| Jedna biblioteka dokumentów dla małego zespołu | Nie |
| Prosta strona informacyjna dla jednego procesu | Raczej nie |
| Lista zadań lub rejestr spraw | Nie |

---

# 3. Checklista przed utworzeniem Hub Site

| Obszar | Co sprawdzić | Status |
|---|---|---:|
| Cel huba | Czy wiadomo, jaki obszar biznesowy hub reprezentuje? |  |
| Zakres | Czy wiadomo, które witryny będą powiązane z hubem? |  |
| Nazwa | Czy nazwa huba jest biznesowa i zrozumiała? |  |
| URL | Czy adres głównej witryny huba jest czytelny? |  |
| Właściciel biznesowy | Czy wskazano osobę lub zespół odpowiedzialny za treści? |  |
| Właściciel techniczny | Czy wiadomo, kto zarządza konfiguracją? |  |
| Nawigacja | Czy zaprojektowano główne menu huba? |  |
| Branding | Czy hub ma mieć własny motyw, logo lub identyfikację? |  |
| Uprawnienia | Czy wiadomo, kto ma dostęp do huba i witryn powiązanych? |  |
| Treści agregowane | Czy wiadomo, jakie aktualności, dokumenty i wydarzenia mają być pokazywane? |  |
| Zarządzanie | Czy wiadomo, kto może dołączać witryny do huba? |  |
| Przeglądy | Czy ustalono cykl przeglądu witryn i uprawnień? |  |

---

# 4. Projekt architektury Hub Site

| Pytanie | Odpowiedź / Uwagi |
|---|---|
| Jaka witryna będzie witryną centralną huba? |  |
| Czy hub reprezentuje dział, proces, projekt, region czy intranet? |  |
| Jakie witryny mają być powiązane z hubem od początku? |  |
| Jakie witryny mogą dojść później? |  |
| Czy hub będzie powiązany z innym hubem nadrzędnym? |  |
| Czy hub będzie miał huby podrzędne? |  |
| Czy potrzebujemy jednego poziomu hubów, czy struktury hub-to-hub? |  |
| Czy nawigacja ma być wspólna dla wszystkich powiązanych witryn? |  |
| Czy treści mają być agregowane ze wszystkich witryn, czy tylko z wybranych? |  |

---

# 5. Checklista tworzenia Hub Site w SharePoint Admin Center

| Krok | Czynność | Status |
|---:|---|---:|
| 1 | Otwórz SharePoint Admin Center |  |
| 2 | Przejdź do **Active sites** |  |
| 3 | Wybierz istniejącą witrynę, która ma zostać hubem |  |
| 4 | Z menu **Hub** wybierz **Register as hub site** |  |
| 5 | Podaj nazwę huba |  |
| 6 | Określ, kto może kojarzyć witryny z hubem |  |
| 7 | Zapisz konfigurację |  |
| 8 | Sprawdź, czy witryna jest widoczna jako Hub Site |  |
| 9 | Skonfiguruj nawigację huba |  |
| 10 | Powiąż pierwsze witryny z hubem |  |

---

# 6. Checklista powiązania witryny z Hub Site

| Pytanie / Czynność | Status |
|---|---:|
| Czy witryna pasuje tematycznie do huba? |  |
| Czy właściciel witryny zgadza się na powiązanie z hubem? |  |
| Czy sprawdzono uprawnienia witryny przed powiązaniem? |  |
| Czy wiadomo, czy witryna ma korzystać z uprawnień huba dla odwiedzających? |  |
| Czy sprawdzono, jak witryna wygląda po powiązaniu? |  |
| Czy nawigacja huba jest widoczna na powiązanej witrynie? |  |
| Czy motyw / branding huba został zastosowany poprawnie? |  |
| Czy aktualności z witryny mają być agregowane na hubie? |  |
| Czy użytkownicy wiedzą, że witryna jest częścią większego obszaru? |  |

## Ważna uwaga

Witryny powiązane z hubem współdzielą nawigację i branding huba, ale nie powinny być traktowane jako proste podwitryny z automatycznym dziedziczeniem uprawnień.

Każda witryna nadal może mieć własny model uprawnień.

---

# 7. Checklista nawigacji Hub Site

| Element | Co sprawdzić | Status |
|---|---|---:|
| Menu główne | Czy menu zawiera najważniejsze obszary biznesowe? |  |
| Nazwy linków | Czy nazwy są zrozumiałe dla użytkowników? |  |
| Kolejność | Czy najczęściej używane sekcje są na początku? |  |
| Linki do witryn | Czy menu prowadzi do powiązanych witryn? |  |
| Linki do stron | Czy menu prowadzi do najważniejszych stron informacyjnych? |  |
| Linki zewnętrzne | Czy są potrzebne linki do aplikacji zewnętrznych? |  |
| Grupy odbiorców | Czy część linków powinna być targetowana do wybranych użytkowników? |  |
| Utrzymanie | Czy wiadomo, kto aktualizuje menu? |  |
| Test użytkownika | Czy zwykły użytkownik rozumie strukturę menu? |  |

## Dobra praktyka

Nie projektuj menu huba według struktury administracyjnej SharePointa.

Lepiej używać języka biznesowego:

```text
Start
Procedury
Dokumenty
Aktualności
Szkolenia
Zgłoszenia
Kontakty
FAQ
```

---

# 8. Checklista uprawnień Hub Site

| Pytanie | Decyzja / Uwagi |
|---|---|
| Kto jest właścicielem huba? |  |
| Kto może edytować stronę główną huba? |  |
| Kto może zarządzać nawigacją huba? |  |
| Kto może kojarzyć witryny z hubem? |  |
| Czy hub ma mieć własną grupę odwiedzających? |  |
| Czy uprawnienia huba mają być synchronizowane z witrynami powiązanymi? |  |
| Czy witryny powiązane mają zachować własne, odrębne uprawnienia? |  |
| Czy dostęp zewnętrzny jest dozwolony? |  |
| Czy zaplanowano okresowy przegląd uprawnień? |  |

## Ważna zasada

Hub Site nie powinien być traktowany jako prosty mechanizm „dziedziczenia uprawnień”.

Domyślnie użytkownik, który ma dostęp do huba, nie musi mieć dostępu do zawartości witryn powiązanych.

---

# 9. Checklista strony głównej Hub Site

| Sekcja | Czy dodać? | Uwagi |
|---|---:|---|
| Krótki opis obszaru huba |  |  |
| Aktualności z huba |  |  |
| Aktualności z powiązanych witryn |  |  |
| Wyróżnione dokumenty |  |  |
| Najważniejsze linki |  |  |
| Lista powiązanych witryn |  |  |
| Wydarzenia |  |  |
| Kontakty do właścicieli obszaru |  |  |
| Sekcja „dla nowych użytkowników” |  |  |
| FAQ |  |  |
| Procedury / instrukcje |  |  |
| Link do zgłoszeń lub formularzy |  |  |

---

# 10. Checklista agregowania treści

| Typ treści | Pytanie kontrolne | Status |
|---|---|---:|
| Aktualności | Czy hub ma pokazywać newsy z powiązanych witryn? |  |
| Dokumenty | Czy mają być pokazywane dokumenty z kilku witryn? |  |
| Wydarzenia | Czy hub ma agregować wydarzenia? |  |
| Strony | Czy mają być promowane konkretne strony? |  |
| Linki | Czy potrzebna jest centralna sekcja linków? |  |
| FAQ | Czy FAQ ma być centralne, czy lokalne dla każdej witryny? |  |
| Procedury | Czy procedury mają być agregowane z różnych obszarów? |  |
| Wyszukiwanie | Czy użytkownicy rozumieją, gdzie szukać informacji? |  |

---

# 11. Checklista brandingu Hub Site

| Element | Decyzja / Uwagi |
|---|---|
| Nazwa huba |  |
| Logo |  |
| Motyw kolorystyczny |  |
| Styl strony głównej |  |
| Standard grafik aktualności |  |
| Standard nazw linków |  |
| Standard układu stron |  |
| Czy powiązane witryny mają wyglądać spójnie? |  |
| Czy hub ma być częścią większego intranetu? |  |

---

# 12. Checklista governance dla Hub Site

| Obszar | Co ustalić |
|---|---|
| Właściciel biznesowy | Kto odpowiada za sens i aktualność huba? |
| Właściciel techniczny | Kto odpowiada za konfigurację? |
| Redaktorzy | Kto może publikować aktualności i strony? |
| Dołączanie witryn | Kto zatwierdza powiązanie nowej witryny z hubem? |
| Nawigacja | Kto aktualizuje menu huba? |
| Branding | Kto pilnuje spójności wyglądu? |
| Uprawnienia | Kto wykonuje przeglądy dostępów? |
| Archiwizacja | Co robimy z nieaktywnymi witrynami? |
| Przegląd cykliczny | Jak często sprawdzamy aktualność treści? |

---

# 13. Checklista po utworzeniu Hub Site

| Czynność | Status |
|---|---:|
| Zarejestrowano witrynę jako Hub Site |  |
| Nadano nazwę huba |  |
| Ustalono właścicieli huba |  |
| Określono osoby/grupy mogące kojarzyć witryny z hubem |  |
| Skonfigurowano nawigację huba |  |
| Skonfigurowano stronę główną huba |  |
| Dodano logo i motyw |  |
| Powiązano pierwsze witryny z hubem |  |
| Sprawdzono branding na powiązanych witrynach |  |
| Sprawdzono widoczność nawigacji huba |  |
| Sprawdzono aktualności agregowane z powiązanych witryn |  |
| Sprawdzono uprawnienia użytkownika zwykłego |  |
| Sprawdzono uprawnienia właściciela witryny powiązanej |  |
| Przygotowano komunikat do użytkowników |  |
| Zaplanowano przegląd po 30 dniach |  |

---

# 14. Minimalny standard dobrego Hub Site

Każdy Hub Site powinien mieć minimum:

1. Jasny cel biznesowy.
2. Czytelną nazwę.
3. Przemyślaną listę witryn powiązanych.
4. Wspólną, prostą nawigację.
5. Właściciela biznesowego.
6. Właściciela technicznego.
7. Zasady dołączania nowych witryn.
8. Zasady publikowania aktualności.
9. Przegląd uprawnień.
10. Przegląd aktualności i linków.
11. Spójny branding.
12. Dokumentację decyzji projektowych.

---

# 15. Najczęstsze błędy przy Hub Site

| Błąd | Skutek |
|---|---|
| Tworzenie huba bez planu informacyjnego | Chaos w portalu |
| Hub dla każdej małej potrzeby | Nadmiar hubów i trudna nawigacja |
| Brak właściciela biznesowego | Hub szybko się dezaktualizuje |
| Zbyt rozbudowane menu | Użytkownicy nie wiedzą, gdzie kliknąć |
| Mylenie huba z mechanizmem dziedziczenia uprawnień | Błędne oczekiwania bezpieczeństwa |
| Dołączanie przypadkowych witryn | Utrata sensu informacyjnego huba |
| Brak standardów nazw | Niespójność portalu |
| Brak przeglądu powiązanych witryn | Stare i nieaktywne witryny zostają w strukturze |
| Brak komunikacji do użytkowników | Hub istnieje, ale nikt z niego nie korzysta |

---

# 16. Szybka decyzja: Hub Site czy zwykła witryna?

| Potrzeba | Najlepsze rozwiązanie |
|---|---|
| Jedna strona informacyjna | Witryna komunikacyjna |
| Mały zespół pracujący na dokumentach | Witryna zespołu |
| Kilka powiązanych witryn działowych | Hub Site |
| Centralny portal HR / IT / Finanse | Hub Site |
| Główny intranet organizacji | Hub Site lub zestaw hubów |
| Proces z jedną listą i formularzem | Lista SharePoint + Power Automate |
| Osobny projekt z własnymi uprawnieniami | Witryna zespołu, ewentualnie powiązana z hubem |

---

# 17. Wzór opisu Hub Site

```text
Nazwa Hub Site:
Adres URL:
Cel huba:
Obszar biznesowy:
Właściciel biznesowy:
Właściciel techniczny:
Redaktorzy:
Kto może kojarzyć witryny z hubem:
Witryny powiązane na start:
Planowane witryny powiązane:
Czy hub ma hub nadrzędny:
Czy hub ma huby podrzędne:
Czy synchronizujemy uprawnienia huba:
Czy dostęp zewnętrzny jest dozwolony:
Data utworzenia:
Data następnego przeglądu:
```

---

# 18. Wzór komunikatu do użytkowników

```text
Dzień dobry,

uruchomiliśmy nowy obszar w SharePoint Online:

[Nazwa Hub Site]

Hub łączy powiązane witryny i pomaga szybciej znaleźć:
- aktualności,
- dokumenty,
- procedury,
- wydarzenia,
- kontakty,
- najważniejsze linki.

Adres huba:
[link]

Powiązane witryny:
- [witryna 1]
- [witryna 2]
- [witryna 3]

Właściciel obszaru:
[imię i nazwisko / zespół]

W przypadku pytań lub propozycji zmian prosimy o kontakt:
[adres e-mail / kanał Teams / formularz]
```

---

# 19. Podsumowanie

Hub Site warto tworzyć wtedy, gdy SharePoint zaczyna być czymś więcej niż pojedynczą witryną.

Najważniejsza zasada:

> Hub Site nie jest tylko technicznym kontenerem. To logiczny obszar portalu, który ma pomóc użytkownikowi znaleźć informacje szybciej i zrozumieć strukturę organizacji.

Praktyczna rekomendacja:

> Najpierw zaprojektuj mapę witryn i nawigację, a dopiero później klikaj **Register as hub site**.
