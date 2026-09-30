# 5.1 Automatic Enrolment: MDM User Scope

Previous: [04-signin-log-ca-tab.md](../04-conditional-access/04-signin-log-ca-tab.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Entra admin center > Entra ID > Mobility (MDM and WIP) > Microsoft Intune. Set MDM user scope to **All** (or Some with `SG-All-Staff`), then Save.

Without this, devices that join Entra never appear in Intune.

## Evidence

![MDM user scope set to All](images/mdm-user-scope.png)

| Setting | Value |
| --- | --- |
| MDM user scope | All |
| MDM terms of use URL | `https://portal.manage.microsoft.com/TermsofUse.aspx` |
| MDM discovery URL | `https://enrollment.manage.microsoft.com/enrollmentserver/discovery.svc` |
| Disable MDM enrollment when adding work or school account on Windows | No |
| WIP user scope | None |

## Notes

The terms of use, discovery and compliance URLs are Microsoft's defaults.
