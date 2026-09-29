# 3.4 Dry Run with -WhatIf

Previous: [01-licence-sku.md](01-licence-sku.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

## Steps

```powershell
./scripts/New-Starter.ps1 -GivenName Ava -Surname Nguyen -Department Sales -JobTitle "Account Executive" -WhatIf
```

Expected: a `What if:` line naming the account, and no user created. Check the Microsoft 365 admin center to be sure.

## Evidence

The dry run is the first command in this screenshot. The six real runs follow it ([03-create-users.md](03-create-users.md)).

![Dry run and user creation](images/whatif-and-create-users.png)

```text
What if: Performing the operation "Create user, set usage location, assign SPB" on target "ava.nguyen@helpdeskco123.onmicrosoft.com".
```

The script builds the address from the tenant's default domain. The dry run passed the connection, duplicate-user and licence checks before printing this line.
