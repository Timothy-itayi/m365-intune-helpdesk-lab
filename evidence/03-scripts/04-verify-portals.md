# 3.6 Verify in the Portals

Previous: [03-create-users.md](03-create-users.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

## Steps

1. Microsoft 365 admin center > Users > Active users: six new users, each with a licence.
2. Wait 5 to 10 minutes. In the Entra admin center, check the dynamic groups:
   - `DG-Sales`: Ava and Ben
   - `DG-Operations`: Chloe and Dan
   - `DG-Finance`: Emma and Farid
3. Add all six users to `SG-All-Staff` by hand: Groups > SG-All-Staff > Members > Add members.

If users are not in the dynamic groups after 15 minutes, open one in Entra and check the Department field matches the rule exactly (spelling and capitals).

## Evidence

Active users, with licences:

![Active users](images/users-list.png)

| Display name | Licence |
| --- | --- |
| Ava Nguyen | Microsoft 365 Business Premium |
| Ben Carter | Microsoft 365 Business Premium |
| Chloe Martin | Microsoft 365 Business Premium |
| Dan Okafor | Microsoft 365 Business Premium |
| Emma Rossi | Microsoft 365 Business Premium |

Farid Haddad is not visible in this screenshot, so it shows five of the six new users. He is in `SG-All-Staff` ([04-sg-all-staff-members.md](../02-groups/04-sg-all-staff-members.md)), which confirms the account exists. His licence is not shown directly. The SKU list shows 7 licences consumed, which is the admin plus all six starters ([01-licence-sku.md](01-licence-sku.md)).

Group membership evidence is in `evidence/02-groups`:

- [DG-Sales members](../02-groups/02-dg-sales-members.md)
- [DG-Operations members](../02-groups/03-dg-operations-members.md)
- [SG-All-Staff members](../02-groups/04-sg-all-staff-members.md)
