# 2.1 DG-Sales Dynamic Membership Rule

Previous: [06-intune-admin-center.md](../01-tenant/06-intune-admin-center.md)

Decision: [04-groups.md](../../docs/decisions/04-groups.md)

## Steps

In the Entra admin center, go to Groups > All groups > New group. Set the membership type to Dynamic User and add a dynamic query using Edit rule syntax.

## Evidence

The rule syntax box for `DG-Sales`.

![DG-Sales rule syntax](images/dg-sales-rules.png)

| Item | Value |
| --- | --- |
| Group | `DG-Sales` |
| Rule | `(user.department -eq "Sales")` |
