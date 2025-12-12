# Checklist – Incident Response (Teams)

## 1. „Nie widzę Teamu / kanału”
- [ ] Membership: Get-TeamUser / właściciele
- [ ] Kanał private/shared: osobne członkostwo kanału
- [ ] Polityki: czy nie blokują dostępu
- [ ] Klient: cache / ponowne logowanie / wersja aplikacji

## 2. Podejrzenie wycieku / nadużycia
- [ ] Ustal: Team, kanał, użytkownik, czas
- [ ] Audit (Unified Audit Log / Purview): RecordType MicrosoftTeams
- [ ] Sprawdź gości i external access
- [ ] Ogranicz polityki lub usuń dostęp (kontrolowanie zmian)

## 3. Aplikacje / boty robią „dziwne rzeczy”
- [ ] App permission policy: czy app ma być dozwolona
- [ ] Review consent / aplikacje w Entra (jeśli dotyczy)
- [ ] Wyłącz / ogranicz + dokumentuj
