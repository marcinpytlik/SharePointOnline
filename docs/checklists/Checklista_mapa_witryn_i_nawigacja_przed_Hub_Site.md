# Checklista projektowania mapy witryn i nawigacji przed utworzeniem Hub Site

## Cel checklisty

Celem tej checklisty jest przygotowanie logicznej struktury portalu SharePoint Online przed rejestracją witryny jako **Hub Site**.

Najważniejsza zasada:

> Najpierw projektujemy strukturę informacyjną, zależności między witrynami i nawigację. Dopiero potem rejestrujemy witrynę jako Hub Site.

---

# 1. Decyzja: po co tworzymy ten obszar?

| Pytanie | Odpowiedź / Uwagi |
|---|---|
| Jaki problem biznesowy ma rozwiązać Hub Site? |  |
| Czy hub ma reprezentować dział, proces, projekt, region czy intranet? |  |
| Kto będzie głównym odbiorcą huba? |  |
| Jakie informacje użytkownik ma znaleźć w tym obszarze? |  |
| Czy użytkownik powinien zaczynać pracę od strony huba? |  |
| Czy hub ma być miejscem komunikacji, dokumentacji, współpracy czy wszystkiego po trochu? |  |
| Czy jedna witryna komunikacyjna nie wystarczy? |  |

---

# 2. Identyfikacja przyszłych witryn

| Pytanie | Odpowiedź / Uwagi |
|---|---|
| Jakie witryny już istnieją i mogą być powiązane z hubem? |  |
| Jakie nowe witryny trzeba utworzyć? |  |
| Które witryny są robocze, a które informacyjne? |  |
| Które witryny mają własnych właścicieli? |  |
| Które witryny mają osobne uprawnienia? |  |
| Które witryny powinny być widoczne w głównej nawigacji? |  |
| Które witryny powinny być ukryte przed zwykłym użytkownikiem, ale powiązane logicznie? |  |

---

# 3. Mapa witryn — wersja robocza

W tym miejscu warto rozpisać strukturę jeszcze zanim cokolwiek klikniesz w SharePoint Admin Center.

```text
Hub Site: [Nazwa obszaru]

├── Witryna główna huba
│   ├── Strona startowa
│   ├── Aktualności
│   ├── Najważniejsze linki
│   └── Kontakty
│
├── Witryna powiązana 1: [nazwa]
│   ├── Cel:
│   ├── Właściciel:
│   ├── Typ: komunikacyjna / zespołu
│   └── Uprawnienia: wspólne / osobne
│
├── Witryna powiązana 2: [nazwa]
│   ├── Cel:
│   ├── Właściciel:
│   ├── Typ: komunikacyjna / zespołu
│   └── Uprawnienia: wspólne / osobne
│
└── Witryna powiązana 3: [nazwa]
    ├── Cel:
    ├── Właściciel:
    ├── Typ: komunikacyjna / zespołu
    └── Uprawnienia: wspólne / osobne
```

---

# 4. Checklista klasyfikacji witryn

| Witryna | Typ | Cel | Właściciel | Widoczna w menu? | Powiązać z hubem? |
|---|---|---|---|---:|---:|
|  | Komunikacyjna / Zespołu |  |  |  |  |
|  | Komunikacyjna / Zespołu |  |  |  |  |
|  | Komunikacyjna / Zespołu |  |  |  |  |
|  | Komunikacyjna / Zespołu |  |  |  |  |

## Kryteria decyzji

Witrynę warto powiązać z hubem, jeżeli:

- tematycznie należy do tego samego obszaru,
- użytkownicy powinni przechodzić do niej z poziomu wspólnej nawigacji,
- jej aktualności lub treści mają być agregowane na stronie huba,
- powinna korzystać ze wspólnego brandingu,
- jej właściciel akceptuje udział w strukturze huba.

---

# 5. Projekt nawigacji głównej huba

| Element menu | Dokąd prowadzi? | Typ linku | Grupa odbiorców | Uwagi |
|---|---|---|---|---|
| Start | Strona główna huba | Strona | Wszyscy |  |
| Aktualności | Strona aktualności | Strona | Wszyscy |  |
| Dokumenty | Biblioteka / witryna | Witryna lub biblioteka | Wszyscy / wybrane grupy |  |
| Procedury | Witryna / strona | Witryna lub strona | Wszyscy |  |
| Szkolenia | Witryna / strona | Witryna lub strona | Wybrane grupy |  |
| Kontakty | Lista / strona | Lista lub strona | Wszyscy |  |
| FAQ | Strona / lista | Strona lub lista | Wszyscy |  |

## Zasada praktyczna

Menu huba powinno odpowiadać pytaniom użytkownika:

- gdzie znajdę dokumenty?
- gdzie są procedury?
- gdzie są aktualności?
- gdzie zgłaszam problem?
- kto jest właścicielem tego obszaru?
- gdzie znajdę kontakt?

Nie projektuj menu według nazw technicznych typu:

```text
SitePages
Documents
Lists
Shared Documents
```

---

# 6. Checklista jakości nawigacji

| Pytanie | Tak/Nie | Uwagi |
|---|---:|---|
| Czy menu jest zrozumiałe dla osoby nietechnicznej? |  |  |
| Czy nazwy linków są biznesowe? |  |  |
| Czy menu nie jest za długie? |  |  |
| Czy najważniejsze linki są na początku? |  |  |
| Czy użytkownik wie, gdzie kliknąć w pierwszych 5 sekundach? |  |  |
| Czy usunięto linki robocze i techniczne? |  |  |
| Czy linki prowadzą do właściwych miejsc? |  |  |
| Czy linki nie dublują się z innymi sekcjami strony głównej? |  |  |
| Czy wybrane linki powinny być targetowane do konkretnych grup? |  |  |
| Czy ktoś będzie odpowiedzialny za aktualizację menu? |  |  |

---

# 7. Projekt strony głównej huba

| Sekcja strony głównej | Cel | Źródło treści | Uwagi |
|---|---|---|---|
| Nagłówek / opis obszaru | Wyjaśnia, czym jest hub | Ręcznie |  |
| Aktualności | Pokazuje komunikaty z huba i witryn powiązanych | Hub + witryny |  |
| Szybkie linki | Prowadzi do najważniejszych miejsc | Ręcznie |  |
| Powiązane witryny | Pokazuje strukturę obszaru | Ręcznie / linki |  |
| Dokumenty | Eksponuje najważniejsze pliki | Biblioteki |  |
| Wydarzenia | Pokazuje terminy i spotkania | Kalendarz / wydarzenia |  |
| Kontakty | Pokazuje właścicieli i redaktorów | Lista / osoby |  |
| FAQ | Odpowiada na typowe pytania | Lista / strona |  |

---

# 8. Checklista agregowania treści

| Pytanie | Tak/Nie | Uwagi |
|---|---:|---|
| Czy hub ma agregować aktualności z powiązanych witryn? |  |  |
| Czy wszystkie witryny mają publikować aktualności? |  |  |
| Czy tylko wybrane witryny mają być źródłem aktualności? |  |  |
| Czy dokumenty mają być prezentowane centralnie? |  |  |
| Czy wydarzenia mają być wspólne dla całego obszaru? |  |  |
| Czy FAQ powinno być centralne czy lokalne? |  |  |
| Czy procedury powinny być w jednej witrynie, czy rozproszone? |  |  |
| Czy użytkownik będzie wiedział, skąd pochodzi dana treść? |  |  |

---

# 9. Checklista uprawnień przed powiązaniem witryn

| Pytanie | Tak/Nie | Uwagi |
|---|---:|---|
| Czy każda witryna ma wskazanych właścicieli? |  |  |
| Czy każda witryna ma uporządkowane grupy członków i odwiedzających? |  |  |
| Czy są witryny z poufną zawartością? |  |  |
| Czy są witryny dostępne tylko dla wybranych grup? |  |  |
| Czy użytkownicy huba mogą nie mieć dostępu do części witryn powiązanych? |  |  |
| Czy synchronizacja uprawnień huba jest potrzebna? |  |  |
| Czy właściciele witryn rozumieją, że powiązanie z hubem nie oznacza automatycznie pełnego dziedziczenia uprawnień? |  |  |
| Czy zaplanowano przegląd uprawnień po powiązaniu z hubem? |  |  |

---

# 10. Macierz decyzji: powiązać czy nie powiązać z hubem?

| Kryterium | Tak/Nie |
|---|---:|
| Witryna należy do tego samego obszaru biznesowego |  |
| Witryna ma sens w nawigacji huba |  |
| Treści z witryny powinny być widoczne szerzej |  |
| Witryna może korzystać ze wspólnego brandingu |  |
| Właściciel witryny akceptuje powiązanie |  |
| Uprawnienia są uporządkowane |  |
| Witryna nie jest archiwalna ani testowa |  |
| Witryna ma aktualną zawartość |  |

## Decyzja

Jeżeli większość odpowiedzi brzmi **tak**, witrynę można powiązać z hubem.

Jeżeli witryna jest techniczna, testowa, archiwalna lub ma bardzo wąski zakres, lepiej jej nie eksponować w strukturze huba.

---

# 11. Checklista nazw i adresów

| Element | Rekomendacja | Status |
|---|---|---:|
| Nazwa huba | Krótka, biznesowa, zrozumiała |  |
| URL huba | Czytelny, bez skrótów niezrozumiałych dla użytkownika |  |
| Nazwy witryn | Spójne z obszarem huba |  |
| Nazwy menu | Proste i użytkowe |  |
| Nazwy bibliotek | Opisujące zawartość |  |
| Nazwy stron | Zrozumiałe w wyszukiwarce |  |
| Nazwy aktualności | Jasne i konkretne |  |

Przykład dobrego nazewnictwa:

```text
/sites/hr
/sites/hr-onboarding
/sites/hr-benefity
/sites/hr-procedury
```

Przykład słabego nazewnictwa:

```text
/sites/site01
/sites/docs-new
/sites/test-hr2
/sites/hr-old-final
```

---

# 12. Test użytkownika przed kliknięciem Register as hub site

Przed utworzeniem huba warto wykonać prosty test:

| Zadanie testowe | Czy użytkownik znalazł? | Uwagi |
|---|---:|---|
| Znajdź procedurę urlopową |  |  |
| Znajdź kontakt do właściciela obszaru |  |  |
| Znajdź najnowsze aktualności |  |  |
| Znajdź dokumenty do pobrania |  |  |
| Znajdź formularz zgłoszenia |  |  |
| Znajdź FAQ |  |  |
| Znajdź witrynę konkretnego zespołu |  |  |

Jeżeli użytkownik nie wie, gdzie kliknąć, problemem nie jest SharePoint — problemem jest projekt informacji.

---

# 13. Minimalny pakiet projektowy przed utworzeniem huba

Zanim klikniesz **Register as hub site**, powinieneś mieć przygotowane:

| Element | Gotowe? |
|---|---:|
| Nazwa huba |  |
| Cel huba |  |
| Lista witryn powiązanych |  |
| Lista właścicieli witryn |  |
| Projekt nawigacji głównej |  |
| Projekt strony głównej huba |  |
| Decyzja o agregowaniu aktualności |  |
| Decyzja o brandingu |  |
| Decyzja o uprawnieniach |  |
| Zasady dołączania nowych witryn |  |
| Plan przeglądu po 30 dniach |  |

---

# 14. Kolejność prac

## Etap 1. Rozpoznanie

- spisz istniejące witryny,
- określ ich właścicieli,
- sprawdź typy witryn,
- sprawdź uprawnienia,
- sprawdź aktualność treści.

## Etap 2. Projekt mapy

- wybierz witrynę główną huba,
- określ witryny powiązane,
- ustal, które witryny będą widoczne w menu,
- ustal, które witryny tylko logicznie należą do huba.

## Etap 3. Projekt nawigacji

- przygotuj menu główne,
- nazwij linki językiem biznesowym,
- usuń techniczne nazwy,
- ogranicz liczbę pozycji,
- przetestuj menu na użytkowniku.

## Etap 4. Projekt strony głównej

- zaplanuj sekcje,
- określ źródła treści,
- przygotuj szybkie linki,
- dodaj kontakty,
- zaplanuj aktualności i dokumenty.

## Etap 5. Decyzja o uprawnieniach

- sprawdź właścicieli,
- sprawdź grupy,
- zdecyduj, czy synchronizować uprawnienia huba,
- ustal wyjątki.

## Etap 6. Dopiero teraz rejestracja huba

Dopiero po wykonaniu wcześniejszych kroków:

```text
SharePoint Admin Center
→ Active sites
→ wybierz witrynę
→ Hub
→ Register as hub site
```

---

# 15. Najczęstsze błędy na tym etapie

| Błąd | Skutek |
|---|---|
| Najpierw kliknięto Register as hub site, a potem zaczęto myśleć o strukturze | Chaos w portalu |
| Brak listy witryn powiązanych | Hub nie ma jasnego zakresu |
| Brak właścicieli witryn | Nie wiadomo, kto odpowiada za treści |
| Menu projektowane technicznie | Użytkownicy się gubią |
| Za dużo pozycji w nawigacji | Menu przestaje pomagać |
| Powiązanie witryn testowych | Bałagan informacyjny |
| Brak decyzji o uprawnieniach | Nieporozumienia dotyczące dostępu |
| Brak testu użytkownika | Portal wygląda dobrze tylko dla autora |
| Brak zasad utrzymania | Hub szybko się dezaktualizuje |

---

# 16. Wzór roboczej mapy huba

```text
Nazwa huba:
Cel huba:
Główny odbiorca:
Właściciel biznesowy:
Właściciel techniczny:

Witryna główna:
- URL:
- Typ:
- Właściciel:

Witryny powiązane:
1. Nazwa:
   URL:
   Typ:
   Cel:
   Właściciel:
   Widoczna w menu: Tak/Nie
   Agregować aktualności: Tak/Nie
   Uwagi:

2. Nazwa:
   URL:
   Typ:
   Cel:
   Właściciel:
   Widoczna w menu: Tak/Nie
   Agregować aktualności: Tak/Nie
   Uwagi:

3. Nazwa:
   URL:
   Typ:
   Cel:
   Właściciel:
   Widoczna w menu: Tak/Nie
   Agregować aktualności: Tak/Nie
   Uwagi:
```

---

# 17. Podsumowanie

Najważniejsza myśl:

> Hub Site jest efektem projektu informacyjnego, a nie początkiem projektu.

Najpierw powinny powstać:

- mapa witryn,
- lista właścicieli,
- projekt nawigacji,
- decyzja o uprawnieniach,
- projekt strony głównej,
- zasady utrzymania.

Dopiero potem warto kliknąć:

```text
Register as hub site
```

Dzięki temu Hub Site nie będzie przypadkowym zbiorem witryn, tylko czytelnym obszarem portalu SharePoint Online.
