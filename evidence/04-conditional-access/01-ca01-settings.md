# 4.2 Policy CA01: Require MFA for All Users

Previous: [00-security-defaults-off.md](00-security-defaults-off.md)

Decision: [06-conditional-access.md](../../docs/decisions/06-conditional-access.md)

## Steps

Entra admin center > Protection > Conditional Access > Policies > New policy.

| Setting | Value |
| --- | --- |
| Name | `CA01 Require MFA - All users` |
| Users | Include All users. Exclude the break-glass account |
| Target resources | All cloud apps |
| Grant | Require multifactor authentication |
| Enable policy | Report-only |

## Evidence

![CA01 settings](images/ca-01-settings.png)

What the screenshot shows:

- **Name:** `CA01 Require MFA - All users`.
- **Users:** "All users included and specific users excluded". The Exclude tab lists 1 user, Break Glass (`breakglass@helpdeskco123.onmicrosoft.com`, truncated).
- **Target resources:** "All resources (formerly 'All cloud apps')". The portal has renamed the All cloud apps option.
- **Grant:** "1 control selected".
- **Enable policy:** Report-only.

## Notes

- The break-glass exclusion matches the Phase 1 decision ([03-tenant.md](../../docs/decisions/03-tenant.md)).
- Conditions shows "0 conditions selected" for this policy.
