# 3.9 Run the Tenant Report

Previous: [08-ben-blocked.md](08-ben-blocked.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

## Steps

```powershell
./scripts/Get-TenantReport.ps1
```

Then type `exit` to leave the container.

Expected: a table of users. Ben appears as disabled, and new users show as never signed in. The script also writes `logs/tenant-report.csv`, which is gitignored.

## Evidence

![Tenant report](images/tenant-report-scripts.png)

| Display name | Department | Enabled | Licensed |
| --- | --- | --- | --- |
| Ava Nguyen | Sales | True | True |
| Ben Carter | Leaver | False | False |
| Break Glass | (none) | True | False |
| Chloe Martin | Operations | True | True |
| Dan Okafor | Operations | True | True |
| Emma Rossi | Finance | True | True |
| Farid Haddad | Finance | True | True |
| help desk | (none) | True | True |
| Timothy Itayi | (none) | True | True |

- **Ben:** disabled and unlicensed, with department `Leaver`, as the leaver script should leave him.
- **Farid:** licensed.
- **Sign-in columns:** `LastSignIn` is empty and `StaleOrNever` is `True` for all nine users.
