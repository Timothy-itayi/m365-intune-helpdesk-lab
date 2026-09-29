# Decisions: Groups

Previous: [03-tenant.md](03-tenant.md)

Phase note: [02-groups.md](../phases/02-groups.md)

Evidence: [00-dg-sales-rule.md](../../evidence/02-groups/00-dg-sales-rule.md), [01-groups-list.md](../../evidence/02-groups/01-groups-list.md)

## Decisions

- Used dynamic membership groups driven by `user.department` for Sales, Operations and Finance, so access follows the user's attribute instead of manual admin work.
- Used an assigned group, `SG-All-Staff`, as the target for company-wide policies.
- Named groups by type: `DG-` for dynamic, `SG-` for assigned security groups.

## Trade-offs

- Dynamic membership can take several minutes to update after an attribute changes.
- Dynamic groups cannot be edited by hand. A leaver cannot be removed from one directly. The leaver process has to change the attribute the rule matches on (here `user.department`), or the rule has to also check `user.accountEnabled`. The current rules do not check it, so disabling an account alone does not remove it from these groups.
