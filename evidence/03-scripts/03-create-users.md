# 3.5 Create the Six Users

Previous: [02-whatif-dry-run.md](02-whatif-dry-run.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

## Steps

Run these one at a time. Copy each temporary password into a password manager (or a scratch note, since the accounts are fictional). Never commit it.

```powershell
./scripts/New-Starter.ps1 -GivenName Ava   -Surname Nguyen  -Department Sales      -JobTitle "Account Executive" -TicketRef INC-0001
./scripts/New-Starter.ps1 -GivenName Ben   -Surname Carter  -Department Sales      -JobTitle "Sales Coordinator"  -TicketRef INC-0001
./scripts/New-Starter.ps1 -GivenName Chloe -Surname Martin  -Department Operations -JobTitle "Operations Lead"    -TicketRef INC-0001
./scripts/New-Starter.ps1 -GivenName Dan   -Surname Okafor  -Department Operations -JobTitle "Dispatcher"         -TicketRef INC-0001
./scripts/New-Starter.ps1 -GivenName Emma  -Surname Rossi   -Department Finance    -JobTitle "Accounts Officer"   -TicketRef INC-0001
./scripts/New-Starter.ps1 -GivenName Farid -Surname Haddad  -Department Finance    -JobTitle "Finance Manager"    -TicketRef INC-0001
```

Expected for each:

```text
Created ava.nguyen@helpdeskco123.onmicrosoft.com
Temporary password (shown once, give to the user securely): ************
Dynamic group 'Sales' membership can take a few minutes to update.
```

## If stuck

| Error | Meaning and fix |
| --- | --- |
| `Not connected` | Re-run `Connect-MgGraph` ([00-connect-mggraph.md](00-connect-mggraph.md)) |
| `Licence SKU 'SPB' not found` | Use the value from the SKU list via `-LicenseSku` |
| Insufficient privileges | Check `(Get-MgContext).Scopes` and reconnect with the scopes listed in step 3.2 |
| `already exists` | The user was created earlier. Skip it |
| Password policy error | Re-run. The generator makes a new password each time |
| `The term 'New-MgUser' is not recognized` | A module is missing. Add it to the `Dockerfile` and rebuild |

## Evidence

![Dry run and user creation](images/whatif-and-create-users.png)

The passwords are blacked out in this screenshot.

| User | Department | Job title |
| --- | --- | --- |
| Ava Nguyen | Sales | Account Executive |
| Ben Carter | Sales | Sales Coordinator |
| Chloe Martin | Operations | Operations Lead |
| Dan Okafor | Operations | Dispatcher |
| Emma Rossi | Finance | Accounts Officer |
| Farid Haddad | Finance | Finance Manager |

The last command is cut off at the right edge of the terminal, so its ticket reads `INC-000` in the screenshot. The actions log file confirms `INC-000` was what got logged for Farid, not `INC-0001` as in the steps above. See [05-actions-log.md](05-actions-log.md).
