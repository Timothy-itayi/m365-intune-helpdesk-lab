# 4.1 Disable Security Defaults

Previous: [09-tenant-report.md](../03-scripts/09-tenant-report.md)

Decision: [06-conditional-access.md](../../docs/decisions/06-conditional-access.md)

## Steps

New tenants have security defaults on, and Conditional Access policies can't be created while they are enabled. Turn them off first.

1. Entra admin center > Identity > Overview > Properties > Manage security defaults.
2. Set Security defaults to **Disabled**.
3. Reason: **My organization is planning to use Conditional Access**.
4. Tick **Replace security defaults by enabling Conditional Access policies**, then Save.

The menu labels shift between portal versions. Searching "security defaults" in the Entra search bar finds the panel.

## Evidence

![Security defaults set to Disabled](images/security-defaults-off.png)

| Setting | Value |
| --- | --- |
| Security defaults | Disabled |
| Reason | My organization is planning to use Conditional Access |
| Replace with Conditional Access policies | Ticked |

The tenant ID is blacked out in the screenshot.

## Result

With security defaults off, MFA is enforced through Conditional Access policies ([02-policy-list-report-only.md](02-policy-list-report-only.md)).
