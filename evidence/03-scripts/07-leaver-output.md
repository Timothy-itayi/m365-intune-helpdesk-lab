# 3.8 Run the Leaver Script

Previous: [06-helpdesk-role-test.md](06-helpdesk-role-test.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

Ben Carter is the leaver.

## Steps

Dry run first, then the real run:

```powershell
./scripts/Remove-Leaver.ps1 -UserPrincipalName ben.carter@helpdeskco123.onmicrosoft.com -TicketRef INC-0004 -WhatIf
./scripts/Remove-Leaver.ps1 -UserPrincipalName ben.carter@helpdeskco123.onmicrosoft.com -TicketRef INC-0004
```

The second command asks for confirmation because the script uses `ConfirmImpact = 'High'`.

## Expected

```text
 - Sign-in blocked; sessions revoked
 - Department set to 'Leaver' (dynamic groups will update)
 - Removed 1 licence(s)
 - Removed from group SG-All-Staff
```

## Result

![Leaver script output](images/leaver-scripts-ben-carter.png)

| Step | Result |
| --- | --- |
| Dry run | `What if: Performing the operation "Offboard user" on target "ben.carter@helpdeskco123.onmicrosoft.com".` Nothing changed. |
| Confirmation | Answered `A` (Yes to All), not `Y` |
| Sign-in blocked; sessions revoked | Done |
| Department set to `Leaver` | Done |
| Licences removed | Done: 1 licence |
| Removed from group `SG-All-Staff` | Done |
| Removed from group `Itayi` | Done. This was not in the expected output. |

- **Extra group removal:** Ben was also a member of the `Itayi` Microsoft 365 group, which is an assigned group. The script removes a user from every assigned group, so it removed him from that one too.
- **Failed earlier run:** the top of the screenshot shows an earlier failed attempt: `Remove-Leaver.ps1: Cannot bind argument to parameter 'UserId' because it is an empty string.` The cause was not recorded. The dry run and the real run after it worked.
- **Log entry:** `logs/actions.csv` has a `Leaver` row for `ben.carter@helpdeskco123.onmicrosoft.com` with ticket `INC-0004`, timestamp `2026-09-29T15:14:38`.

## Not shown

- Ben's removal from `DG-Sales`. The script changes his department to `Leaver` and the dynamic group should drop him after a few minutes, but no screenshot shows the group afterwards.
- Ben's licence status in the admin center. The tenant report ([09-tenant-report.md](09-tenant-report.md)) shows him unlicensed.
