# 5.4 Update Ring

Previous: [02-config-profile.md](02-config-profile.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center > Devices > Windows updates > Update rings for Windows 10 and later > Create profile.

| Setting | Value |
| --- | --- |
| Name | `Win-Updates-Standard` |
| Quality update deferral | 3 days |
| Deadline | 5 days |
| Assignments | `SG-All-Staff` |

## Evidence

![Win-Updates-Standard review page](images/update-ring.png)

The screenshot is the **Review + create** page, before the ring was created.

| Item | Value shown |
| --- | --- |
| Quality update deferral period | 3 days |
| Feature update deferral period | 5 days |
| Servicing channel | General Availability channel |
| Microsoft product updates | Allow |
| Windows drivers | Allow |
| Automatic update behavior | Auto install at maintenance time |
| Active hours | 8 AM to 5 PM |
| Use deadline settings | Not configured |
| Feature update uninstall period | 10 days |
| Upgrade Windows 10 devices to latest Windows 11 | No |

## What this proves, and what it doesn't

- The quality deferral is 3 days, as planned.
- **The 5 is a feature update deferral, not a deadline.** "Use deadline settings" is Not configured, so no deadline is set. The tutorial asked for a 5-day deadline.
- **No assignment is visible.** `SG-All-Staff` does not appear in the screenshot.
- It is the page before Create, so it does not prove the ring exists.
- Active hours, the update behaviour and the 10-day uninstall period were not chosen in the tutorial. I don't know whether they are Intune defaults or values I set.
