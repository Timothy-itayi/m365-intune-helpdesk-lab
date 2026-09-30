# 5.3 Configuration Profile

Previous: [01-compliance-policy.md](01-compliance-policy.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center > Devices > Configuration > Create > New policy > Windows 10 and later > Settings catalog.

Name: `Win-Config-Baseline`. Add the machine inactivity limit (900 seconds) and the Windows consumer experience settings from the catalogue, then assign the profile to `SG-All-Staff`.

## Evidence

The settings page of the created profile (Edit profile, step 1 of 2):

![Win-Config-Baseline settings](images/config-profile-settings.png)

| Category | Setting | Value |
| --- | --- | --- |
| Experience (2 of 30 configured) | Allow Windows Spotlight (User) | Allow |
| Experience | Allow Windows Consumer Features | **Allow** |
| Local Policies Security Options (1 of 84 configured) | Interactive Logon Machine Inactivity Limit | 900 |

The Review + create page of the profile:

![Win-Config-Baseline review page](images/config-profile.png)

It shows the same two Experience settings.

## Result

The profile exists and sets a machine inactivity limit of 900 seconds.
