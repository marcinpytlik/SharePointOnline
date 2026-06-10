# Checklista tworzenia witryny w SharePoint Online

## Cel dokumentu

Celem checklisty jest uporządkowanie procesu tworzenia nowej witryny w SharePoint Online. Dokument pomaga zdecydować:

- czy nowa witryna jest faktycznie potrzebna,
- jaki typ witryny wybrać,
- jakie elementy należy przygotować przed utworzeniem witryny,
- co skonfigurować po jej utworzeniu,
- jak zadbać o uprawnienia, strukturę, bezpieczeństwo i utrzymanie.

---

# 1. Decyzja: czy w ogóle tworzyć nową witrynę?

| Pytanie kontrolne | Tak/Nie | Uwagi |
|---|---:|---|
| Czy potrzebujemy osobnego miejsca na dokumenty, strony, listy lub komunikację? |  |  |
| Czy zawartość ma mieć osobnych właścicieli? |  |  |
| Czy dostęp ma być inny niż w istniejących witrynach? |  |  |
| Czy istniejąca biblioteka dokumentów lub lista nie wystarczy? |  |  |
| Czy treści mają być dostępne przez dłuższy czas, a nie tylko tymczasowo? |  |  |
| Czy witryna będzie częścią większego portalu, działu lub projektu? |  |  |
| Czy potrzebna jest własna nawigacja, strony startowe, aktualności lub web party? |  |  |

## Decyzja

Jeżeli większość odpowiedzi brzmi **tak**, osobna witryna ma sens.

Jeżeli chodzi tylko o kilka plików, prostą listę lub niewielki zestaw informacji, lepiej rozważyć użycie istniejącej witryny.

---

# 2. Wybór typu witryny

W SharePoint Online najczęściej wybieramy między:

- **witryną zespołu**,
- **witryną komunikacyjną**,
- **witryną powiązaną z hubem**,
- **hub site**, czyli witryną centralną dla powiązanych obszarów.

| Scenariusz | Zalecany typ |
|---|---|
| Praca zespołu nad dokumentami | Witryna zespołu |
| Projekt, zespół, dział roboczy | Witryna zespołu |
| Portal informacyjny dla wielu użytkowników | Witryna komunikacyjna |
| Intranet, dział HR, IT, komunikaty firmowe | Witryna komunikacyjna |
| Strona główna większego obszaru organizacji | Witryna komunikacyjna albo hub |
| Zbiór powiązanych witryn działowych lub projektowych | Hub site |

---

# 3. Checklista przed utworzeniem witryny

| Obszar | Co sprawdzić | Status |
|---|---|---:|
| Nazwa | Czy nazwa jest krótka, zrozumiała i zgodna ze standardem organizacji? |  |
| Adres URL | Czy adres będzie czytelny, np. `/sites/hr`, `/sites/projekt-x`? |  |
| Cel witryny | Czy wiadomo, po co witryna powstaje? |  |
| Typ witryny | Czy ma to być witryna zespołu, komunikacyjna, hub czy witryna powiązana z hubem? |  |
| Właściciele | Czy wskazano minimum dwóch właścicieli? |  |
| Członkowie | Czy wiadomo, kto ma edytować zawartość? |  |
| Odwiedzający | Czy wiadomo, kto ma tylko czytać? |  |
| Poufność danych | Czy witryna będzie zawierała dane publiczne, wewnętrzne, poufne lub wrażliwe? |  |
| Retencja | Czy dokumenty mają mieć określony czas przechowywania? |  |
| Struktura | Czy wiemy, jakie biblioteki, listy i strony będą potrzebne? |  |
| Nawigacja | Czy witryna ma być częścią większej struktury portalu? |  |
| Język | Czy witryna ma być tylko po polsku, czy wielojęzyczna? |  |
| Szablon | Czy istnieje firmowy szablon witryny? |  |
| Branding | Czy wymagane są logo, kolory, stopka lub grafiki? |  |
| Wyszukiwanie | Czy treści mają być łatwo znajdowane przez użytkowników? |  |

---

# 4. Checklista uprawnień

| Pytanie | Decyzja / Uwagi |
|---|---|
| Kto będzie właścicielem witryny? |  |
| Kto będzie mógł dodawać i edytować dokumenty? |  |
| Kto będzie miał tylko odczyt? |  |
| Czy dostęp będzie nadawany przez grupy Microsoft 365 lub Entra ID? |  |
| Czy należy unikać nadawania uprawnień pojedynczym osobom? |  |
| Czy zewnętrzne udostępnianie ma być dozwolone? |  |
| Czy użytkownicy mogą udostępniać dokumenty dalej? |  |
| Czy potrzebne są osobne uprawnienia do wybranych bibliotek? |  |
| Czy ktoś będzie okresowo przeglądał uprawnienia? |  |

## Dobra praktyka

Nie projektuj witryny od wyjątków.

Najpierw ustaw proste grupy:

- **Właściciele**,
- **Członkowie**,
- **Odwiedzający**.

Dopiero później rozważ szczegółowe wyjątki.

---

# 5. Checklista struktury witryny

| Element | Czy potrzebny? | Uwagi |
|---|---:|---|
| Strona główna |  |  |
| Aktualności |  |  |
| Biblioteka dokumentów głównych |  |  |
| Biblioteka dokumentów archiwalnych |  |  |
| Lista kontaktów |  |  |
| Lista zadań / spraw |  |  |
| Lista FAQ |  |  |
| Lista procedur |  |  |
| Kalendarz / harmonogram |  |  |
| Linki do aplikacji zewnętrznych |  |  |
| Sekcja „ważne dokumenty” |  |  |
| Sekcja „ostatnio dodane” |  |  |
| Sekcja „dla nowych pracowników” |  |  |

---

# 6. Checklista bibliotek dokumentów

| Pytanie | Tak/Nie | Uwagi |
|---|---:|---|
| Czy jedna biblioteka wystarczy? |  |  |
| Czy dokumenty trzeba podzielić według działów, procesów lub poziomu poufności? |  |  |
| Czy potrzebne są metadane zamiast folderów? |  |  |
| Czy trzeba włączyć wersjonowanie? |  |  |
| Czy wymagane jest zatwierdzanie dokumentów? |  |  |
| Czy dokumenty mają mieć właściciela biznesowego? |  |  |
| Czy potrzebne są szablony dokumentów? |  |  |
| Czy dokumenty mają być synchronizowane lokalnie przez OneDrive? |  |  |
| Czy są ograniczenia dotyczące udostępniania zewnętrznego? |  |  |
| Czy potrzebna jest polityka retencji? |  |  |

---

# 7. Checklista list SharePoint

| Pytanie | Tak/Nie | Uwagi |
|---|---:|---|
| Czy dane powinny być przechowywane jako lista zamiast Excela? |  |  |
| Czy użytkownicy mają filtrować, sortować i grupować dane? |  |  |
| Czy potrzebne są widoki, np. „aktywne”, „archiwalne”, „moje sprawy”? |  |  |
| Czy kolumny mają być obowiązkowe? |  |  |
| Czy potrzebne są kolumny wyboru, daty, osoby, linku lub załączników? |  |  |
| Czy lista będzie używana w Power Automate? |  |  |
| Czy lista będzie źródłem danych dla Power Apps? |  |  |
| Czy potrzebne są alerty lub powiadomienia? |  |  |

---

# 8. Checklista nawigacji

| Element | Decyzja / Uwagi |
|---|---|
| Czy witryna ma mieć własne menu główne? |  |
| Czy ma być widoczna w nawigacji huba? |  |
| Czy linki mają prowadzić do bibliotek, list, stron czy aplikacji? |  |
| Czy nawigacja ma być prosta dla użytkownika nietechnicznego? |  |
| Czy nazwy w menu są biznesowe, a nie techniczne? |  |
| Czy usunięto zbędne linki domyślne? |  |
| Czy najważniejsze treści są dostępne z poziomu strony głównej? |  |

## Dobra praktyka

Nawigacja powinna odpowiadać językowi biznesu, a nie strukturze technicznej SharePointa.

Przykład:

Zamiast:

```text
Documents
Lists
SitePages
```

lepiej:

```text
Dokumenty
Procedury
Kontakty
Aktualności
FAQ
```

---

# 9. Checklista strony głównej

| Sekcja | Czy dodać? | Uwagi |
|---|---:|---|
| Krótki opis celu witryny |  |  |
| Aktualności |  |  |
| Najważniejsze dokumenty |  |  |
| Szybkie linki |  |  |
| Osoby kontaktowe |  |  |
| Procedury / instrukcje |  |  |
| FAQ |  |  |
| Ostatnio zmodyfikowane dokumenty |  |  |
| Link do zgłoszeń / formularzy |  |  |
| Komunikat właściciela witryny |  |  |

## Zasada praktyczna

Strona główna nie powinna być magazynem wszystkiego.

Jej zadaniem jest szybkie prowadzenie użytkownika do najważniejszych miejsc.

---

# 10. Checklista bezpieczeństwa i zgodności

| Obszar | Co sprawdzić | Status |
|---|---|---:|
| Uprawnienia | Czy dostęp mają tylko właściwe osoby? |  |
| Zewnętrzne udostępnianie | Czy jest potrzebne i zgodne z polityką firmy? |  |
| Wrażliwe dane | Czy witryna może przechowywać dane osobowe lub poufne? |  |
| Retencja | Czy dokumenty mają być przechowywane przez określony czas? |  |
| Etykiety poufności | Czy trzeba zastosować sensitivity labels? |  |
| Audyt | Czy wymagane jest śledzenie aktywności? |  |
| Właściciele | Czy jest więcej niż jeden właściciel? |  |
| Przegląd dostępu | Czy zaplanowano cykliczny przegląd uprawnień? |  |

---

# 11. Checklista po utworzeniu witryny

| Czynność | Status |
|---|---:|
| Sprawdzono nazwę i adres witryny |  |
| Dodano właścicieli |  |
| Dodano członków |  |
| Dodano odwiedzających |  |
| Zweryfikowano uprawnienia |  |
| Skonfigurowano stronę główną |  |
| Utworzono potrzebne biblioteki |  |
| Utworzono potrzebne listy |  |
| Ustawiono wersjonowanie dokumentów |  |
| Ustawiono metadane / kolumny |  |
| Skonfigurowano widoki |  |
| Ustawiono nawigację |  |
| Dodano logo / elementy graficzne |  |
| Sprawdzono widok mobilny |  |
| Sprawdzono wyszukiwanie |  |
| Przetestowano dostęp jako zwykły użytkownik |  |
| Opublikowano stronę główną |  |
| Poinformowano użytkowników o nowej witrynie |  |

---

# 12. Minimalny standard dobrej witryny

Każda nowa witryna powinna mieć minimum:

1. Jasny cel — po co istnieje.
2. Dwóch właścicieli — żeby nie było osieroconej witryny.
3. Proste grupy uprawnień — właściciele, członkowie, odwiedzający.
4. Czytelną stronę główną — bez przeładowania.
5. Przemyślane biblioteki dokumentów — nie wszystko w jednej stercie.
6. Wersjonowanie dokumentów — obowiązkowo.
7. Nawigację biznesową — użytkownik ma rozumieć, gdzie kliknąć.
8. Przegląd po 30 dniach — co działa, co trzeba poprawić.
9. Przegląd uprawnień co kwartał.
10. Właściciela treści — nie tylko właściciela technicznego.

---

# 13. Szybka decyzja: witryna, biblioteka czy lista?

| Potrzeba | Najlepsze rozwiązanie |
|---|---|
| Kilka dokumentów dla istniejącego zespołu | Biblioteka w istniejącej witrynie |
| Rejestr spraw, zadań, kontaktów, procedur | Lista SharePoint |
| Nowy dział, projekt lub obszar z własnymi uprawnieniami | Nowa witryna zespołu |
| Portal informacyjny dla wielu osób | Witryna komunikacyjna |
| Główna struktura intranetu / działu | Hub site |
| Prosty formularz i proces akceptacji | Lista + Power Automate |
| Dokumenty z różnymi poziomami dostępu | Osobne biblioteki lub osobna witryna |

---

# 14. Rekomendowany proces tworzenia witryny

## Krok 1. Określ cel

Odpowiedz na pytania:

- po co powstaje witryna?
- kto będzie jej używał?
- jakie treści będą w niej przechowywane?
- czy witryna ma charakter roboczy, projektowy, informacyjny czy portalowy?

## Krok 2. Wybierz typ witryny

Wybierz jeden z wariantów:

- witryna zespołu,
- witryna komunikacyjna,
- witryna powiązana z hubem,
- hub site.

## Krok 3. Zaprojektuj uprawnienia

Ustal:

- właścicieli,
- członków,
- odwiedzających,
- ewentualne grupy zewnętrzne,
- zasady udostępniania.

## Krok 4. Zaprojektuj strukturę

Określ:

- biblioteki dokumentów,
- listy,
- strony,
- metadane,
- widoki,
- nawigację.

## Krok 5. Utwórz witrynę

Po utworzeniu witryny sprawdź:

- nazwę,
- adres URL,
- typ witryny,
- język,
- właścicieli,
- ustawienia prywatności.

## Krok 6. Skonfiguruj zawartość

Dodaj:

- stronę główną,
- biblioteki,
- listy,
- web party,
- linki,
- logo,
- elementy nawigacji.

## Krok 7. Przetestuj

Sprawdź:

- dostęp właściciela,
- dostęp członka,
- dostęp odwiedzającego,
- działanie linków,
- widoki bibliotek,
- wyszukiwanie,
- wygląd na urządzeniach mobilnych.

## Krok 8. Opublikuj i poinformuj użytkowników

Przed przekazaniem witryny użytkownikom przygotuj krótką informację:

- gdzie znajduje się witryna,
- do czego służy,
- kto jest właścicielem,
- jakie są najważniejsze sekcje,
- gdzie zgłaszać uwagi.

---

# 15. Najczęstsze błędy

| Błąd | Skutek |
|---|---|
| Tworzenie witryny bez jasnego celu | Chaos informacyjny |
| Jeden właściciel witryny | Ryzyko osierocenia witryny |
| Zbyt wiele bibliotek bez planu | Użytkownicy nie wiedzą, gdzie zapisywać dokumenty |
| Nadużywanie folderów | Trudniejsze wyszukiwanie i filtrowanie |
| Brak metadanych | Gorsza organizacja dokumentów |
| Nadawanie uprawnień pojedynczym osobom | Trudne utrzymanie bezpieczeństwa |
| Brak przeglądu uprawnień | Ryzyko nadmiarowego dostępu |
| Przeładowana strona główna | Użytkownicy nie korzystają z witryny |
| Brak właściciela treści | Witryna szybko się dezaktualizuje |
| Brak komunikacji do użytkowników | Użytkownicy nie wiedzą, że witryna istnieje |

---

# 16. Wzór krótkiego opisu witryny

```text
Nazwa witryny:
Cel witryny:
Typ witryny:
Właściciel biznesowy:
Właściciel techniczny:
Główne grupy użytkowników:
Rodzaj przechowywanych danych:
Czy witryna zawiera dane poufne:
Czy dozwolone jest udostępnianie zewnętrzne:
Powiązanie z hubem:
Data utworzenia:
Data następnego przeglądu:
```

---

# 17. Wzór komunikatu do użytkowników

```text
Dzień dobry,

została uruchomiona nowa witryna SharePoint Online:

[Nazwa witryny]

Witryna służy do:
- przechowywania dokumentów,
- publikowania aktualności,
- udostępniania procedur,
- współpracy zespołowej.

Adres witryny:
[link]

Właściciel witryny:
[imię i nazwisko / zespół]

W przypadku pytań lub problemów prosimy o kontakt:
[adres e-mail / kanał Teams / formularz zgłoszeniowy]
```

---

# 18. Podsumowanie

Dobra witryna SharePoint Online powinna być:

- celowa,
- prosta,
- bezpieczna,
- czytelna,
- łatwa w utrzymaniu,
- zrozumiała dla użytkownika biznesowego.

Najważniejsze pytanie przed utworzeniem nowej witryny brzmi:

> Czy naprawdę potrzebujemy nowej witryny, czy wystarczy biblioteka, lista albo strona w istniejącym miejscu?

Jeżeli odpowiedź jest jasna, dopiero wtedy warto przejść do projektowania struktury, uprawnień i zawartości.
