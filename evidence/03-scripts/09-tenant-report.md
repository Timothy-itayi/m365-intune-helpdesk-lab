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
- **Farid:** licensed, which closes the earlier gap where his licence was not visible.
- **Sign-in columns:** `LastSignIn` is empty and `StaleOrNever` is `True` for all nine users.

## Problem with the sign-in columns

`StaleOrNever` says "never signed in" for accounts that have signed in. The admin account (Timothy Itayi) and the helpdesk user both signed in during this phase. The report therefore cannot yet be trusted for stale-account detection.

The cause is not established. Graph sign-in activity may lag behind real sign-ins, but that is unconfirmed. Re-run the report later and see whether the admin's `LastSignIn` fills in.
