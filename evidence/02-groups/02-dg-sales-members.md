# 2.3 DG-Sales Members

Previous: [01-groups-list.md](01-groups-list.md)

Decision: [04-groups.md](../../docs/decisions/04-groups.md)

## Steps

After the six starters were created ([03-create-users.md](../03-scripts/03-create-users.md)), wait 5 to 10 minutes. In the Entra admin center, go to Groups > DG-Sales > Members.

Expected: Ava Nguyen and Ben Carter.

## Evidence

![DG-Sales members](images/dg-sales-members.png)

| Item | Value |
| --- | --- |
| Group | `DG-Sales` |
| Members found | 2 |
| Members | Ava Nguyen, Ben Carter |

Neither user was added by hand. The "Add members" button is disabled on a dynamic group, so the dynamic rule did this from `user.department`.
