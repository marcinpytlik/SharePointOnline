# Checklist – Incident Response (SPO)

## 1. Zniknął plik / folder
- [ ] Zidentyfikuj site + bibliotekę + ścieżkę
- [ ] Sprawdź Recycle Bin (1st i 2nd stage)
- [ ] Sprawdź historię wersji
- [ ] Audit: FileDeleted / FileMoved / FileRenamed
- [ ] Uprawnienia: czy nie „odcięto” dostępu (unikalne perms)

## 2. Podejrzenie wycieku (external sharing)
- [ ] Ustal obiekt (plik/folder/site)
- [ ] Audit: AnonymousLinkCreated / SecureLinkCreated / SharingSet
- [ ] Sprawdź politykę sharing dla site’a
- [ ] Usuń linki udostępnień / ogranicz politykę (per-site)
- [ ] Eskalacja do compliance (jeśli wymagane)

## 3. Nadużycie uprawnień
- [ ] Audit: PermissionChanged / AddedToGroup / SiteCollectionAdminAdded
- [ ] Weryfikacja membership grup
- [ ] Cofnięcie zmian + dokumentacja incydentu
- [ ] Działanie zapobiegawcze (governance / szkolenie ownerów)
