# Phase 2: Groups

Previous: [01-tenant.md](01-tenant.md)

Decisions: [04-groups.md](../decisions/04-groups.md)

## Objective

Make access follow attributes instead of manual admin work.

## Design

| Group | Type | Rule / membership | Purpose |
|---|---|---|---|
| DG-Sales | Dynamic | user.department -eq "Sales" | Sales team access and policies |
| DG-Operations | Dynamic | user.department -eq "Operations" | Operations team |
| DG-Finance | Dynamic | user.department -eq "Finance" | Finance team |
| SG-All-Staff | Assigned | manual | Target for company-wide policies |

## Why dynamic groups

When someone changes department, their group membership updates without an admin
touching it, reducing forgotten access after moves.

## Evidence

Step write-ups, in order:

1. [DG-Sales rule](../../evidence/02-groups/00-dg-sales-rule.md)
2. [Groups list](../../evidence/02-groups/01-groups-list.md)

Screenshots:

- ![DG-Sales rule](../../evidence/02-groups/images/dg-sales-rules.png)
- ![Groups list](../../evidence/02-groups/images/groups-list.png)

## Limits I noted

Dynamic membership can take several minutes to update. Dynamic groups can't be
edited by hand, which matters for the leaver process.
