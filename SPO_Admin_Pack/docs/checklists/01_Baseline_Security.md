# Checklist – Baseline bezpieczeństwa (SPO / OneDrive)

## A. Tożsamość i dostęp (Entra)
- [ ] MFA dla wszystkich adminów (minimum) oraz użytkowników z dostępem zewnętrznym
- [ ] Conditional Access: blokada legacy auth (jeśli dotyczy)
- [ ] Przegląd aplikacji (App registrations / Enterprise apps) z dostępem do M365
- [ ] Zasada najmniejszych uprawnień (role adminów)

## B. SharePoint Admin Center – globalnie
- [ ] External sharing: poziom maksymalny ustawiony świadomie
- [ ] Anonymous links: wyłączone lub z krótkim TTL (jeśli dozwolone)
- [ ] Domyślne typy linków (preferuj „Specific people” / „Existing access”)
- [ ] OneDrive sharing: spójne z tenant policy

## C. Purview / Audit
- [ ] Audyt włączony (Audit)
- [ ] Retencja logów zgodna z wymaganiami (reguły organizacji)
- [ ] Procedura incydentu: gdzie i jak sprawdzać „kto zrobił co”
