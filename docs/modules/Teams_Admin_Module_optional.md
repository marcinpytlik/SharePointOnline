---
title: "Microsoft Teams – Administracja (Moduł)"
author: "marcin"
date: "2025-12-12"
license: "CC BY 4.0"
---

# Microsoft Teams – administracja (moduł duży)

Ten materiał jest dla admina, który chce ogarniać Teams **operacyjnie**: governance, bezpieczeństwo, polityki, dochodzenie incydentów i automatyzację PowerShellem.

**Cel:** po przerobieniu modułu potrafisz:
- utrzymać porządek w Teamach (naming, owners, lifecycle, archiwizacja),
- ustawić baseline bezpieczeństwa (goście, dostęp zewnętrzny, aplikacje),
- zarządzać politykami (meeting/messaging/app/channels),
- diagnozować typowe awarie i „niedostępy”,
- zrobić raporty z PowerShell i podstawowy audyt (Unified Audit Log).

> Teams to nie „jedna aplikacja”. To warstwa UX na: Entra (tożsamość), M365 Groups (członkostwo), SharePoint (pliki), Exchange (kalendarz), Stream/OneDrive (nagrania), Purview (compliance).

---

## 0. Warstwy admina: gdzie się robi co

- **Teams admin center** – polityki, konfiguracje, aplikacje, ustawienia organizacji.
- **Entra ID** – goście, B2B, Conditional Access, tożsamości i grupy.
- **SharePoint admin center** – bo pliki Teams siedzą w SPO (kanały = foldery/biblioteki).
- **Microsoft Purview** – audit/retention/eDiscovery (jeśli używane).
- **PowerShell** – automatyzacja i raporty (Teams module + opcjonalnie audyt).

---

## 1. Architektura Teams (ważne dla troubleshooting)

### 1.1 Team = Microsoft 365 Group + SharePoint site
W praktyce oznacza to:
- członkostwo/ownerzy – trzymane w M365 Group,
- pliki kanałów – w SharePoint,
- rozmowy – w Teams,
- spotkania – w kalendarzu i politykach meeting.

### 1.2 Kanały: standard / private / shared
- Standard: „wspólne” pliki w głównym site’cie Team.
- Private/Shared: mają dodatkową izolację (a czasem osobne zasoby SPO) → częste źródło „czemu nie widzę plików”.

---

## 2. Governance: jak nie zrobić „Teams sprawl”

### 2.1 Minimalny governance (wdrażalny od jutra)
- Konwencja nazw (dział/projekt) + sensowny opis,
- Minimum **2 ownerów** w każdym Teamie,
- Kontrola tworzenia Teamów (kto może tworzyć M365 Groups),
- Proces: request → approval → creation,
- Przegląd kwartalny: owners, goście, zewnętrzny dostęp, archiwizacja.

### 2.2 Lifecycle
- Create → Operate → Review → Archive → Delete/Retain
- Archiwizacja to super narzędzie: ograniczasz hałas, nie tracąc danych.

W pakiecie masz raport, który wyłapuje Teamy z <2 ownerami i archiwizowane.

---

## 3. Bezpieczeństwo: guest/external, aplikacje, dostęp

### 3.1 Guest access vs external access (nie mylić)
- **Guest access**: użytkownik B2B (gość) w Twoim tenancie.
- **External access (federation)**: czat/połączenia z innymi tenantami bez dodawania gościa.

### 3.2 Baseline (praktyczny)
- MFA / Conditional Access dla adminów i użytkowników z dostępem zewnętrznym,
- Ogranicz guest access do uzasadnionych przypadków,
- Aplikacje: allow-list (minimum), kontrola custom apps,
- Polityki meeting: ograniczenia nagrań/udostępnień zgodnie z organizacją.

---

## 4. Polityki Teams: co jest kluczowe i gdzie uderzać

Najczęściej dotykane polityki:
- Messaging policy (czaty, edycja/usuwanie, Giphy/URL preview itp.),
- Meeting policy (nagrywanie, lobby, anonimy, transkrypcje),
- Channels policy (private/shared),
- App permission / app setup policy (co wolno instalować i co jest przypięte).

W pakiecie masz:
- `scripts/Get-TeamsPoliciesSnapshot.ps1` – zrzut polityk do CSV,
- `scripts/Set-TeamsMessagingPolicyExample.ps1` – template kontrolowanej zmiany (z -WhatIf).

---

## 5. Audyt i dochodzenie (incydenty)

### 5.1 Źródło prawdy
- Unified Audit Log / Purview (jeśli włączone i dostępne) – zdarzenia Teams są jednym z record type’ów.

### 5.2 Typowe incydenty
1) „Kto dodał gościa / zmienił membership?”
2) „Kto utworzył kanał / team?”
3) „Kto usunął coś lub zmienił ustawienie?”

W pakiecie:
- `scripts/Get-UnifiedAuditLog_Teams.ps1` – pobiera audyt po RecordType=MicrosoftTeams.

---

## 6. Troubleshooting: 10 klasyków i tropy

1) Użytkownik nie widzi Teamu → membership/owner, licencja, polityka, cache klienta  
2) Gość nie działa → B2B, zaproszenie, polityki guest, CA  
3) Kanał prywatny „zniknął” → brak członkostwa kanału private/shared  
4) Pliki nie otwierają się → problem SPO/permissions, a nie Teams  
5) Brak nagrania spotkania → polityka meeting/Stream/OneDrive/SPO + uprawnienia  
6) Aplikacja zablokowana → app permission policy  
7) Nie działa czat z inną firmą → external access / federation  
8) Nie da się tworzyć Teamów → ograniczenia tworzenia M365 Groups  
9) Spotkania: lobby/anonym → meeting policy  
10) „Teams wolno działa” → klient, sieć, cache, status usługi

---

## 7. Automatyzacja: PowerShell (Twoje „narzędzie admina”)

### 7.1 Governance report
Skrypt:
- `scripts/Get-TeamsGovernanceReport.ps1`

Wyniki:
- `Teams_Teams.csv`
- `Teams_Owners.csv`
- `Teams_Channels.csv`
- `Teams_Governance_Summary.md`

### 7.2 Zrzut polityk
- `scripts/Get-TeamsPoliciesSnapshot.ps1 -OutputPath .\scripts\reports`

### 7.3 Audyt Teams
- `scripts/Get-UnifiedAuditLog_Teams.ps1 -LookbackDays 7 -OutputPath .\scripts\reports`

---

## 8. Laby
W folderze `docs/labs/` są krótkie ćwiczenia: governance, polityki, audyt.

---

## 9. Appendix – szybki start

### Instalacja modułów
```powershell
.\scripts\Install-Modules.ps1
# audyt:
.\scripts\Install-Modules.ps1 -IncludeExchangeOnline
```

### Governance report
```powershell
copy .\scripts\settings.example.json .\scripts\settings.json
.\scripts\Get-TeamsGovernanceReport.ps1 -SettingsPath .\scripts\settings.json
```
