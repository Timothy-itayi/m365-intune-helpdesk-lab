# 5.3 Configuration Profile

Previous: [01-compliance-policy.md](01-compliance-policy.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center > Devices > Configuration > Create > New policy > Windows 10 and later > Settings catalog.

| Setting | Value |
| --- | --- |
| Name | `Win-Config-Baseline` |
| Machine inactivity limit | 900 seconds |
| Microsoft consumer experiences | Turned off |
| Assignments | `SG-All-Staff` |

## Evidence

![Win-Config-Baseline review page](images/config-profile.png)

The screenshot is the **Review + create** page, before the profile was created.

| Item | Value shown |
| --- | --- |
| Name | Win-Config-Baseline |
| Platform | Windows, Settings catalog |
| Allow Windows Spotlight (User) | Allow |
| Allow Windows Consumer Features | **Allow** |
| Local Policies Security Options | Collapsed |
| Scope tags | Default |
| Included groups | **Empty** |

## What this proves, and what it doesn't

- **Consumer features are not turned off in this screenshot.** The setting reads Allow. The tutorial asked for Microsoft consumer experiences to be turned off. If the intent was to block them, this page says otherwise.
- **The machine inactivity limit is not visible.** It sits in the collapsed Local Policies Security Options section, so 900 seconds is not shown.
- **No group is assigned in this screenshot.** The Included groups table is empty, although the Assignments step has a green tick. `SG-All-Staff` is not shown.
- It is the page before Create, so it does not prove the profile exists.

To close this: open the created profile, check Properties and Assignments, and capture the inactivity limit, the consumer features setting and `SG-All-Staff`. If the settings are wrong, edit the profile and record the change.
