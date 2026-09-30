# 5.4 Update Ring

Previous: [02-config-profile.md](02-config-profile.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center > Devices > Windows updates > Update rings for Windows 10 and later > Create profile.

Name: `Win-Updates-Standard`. Set the quality update deferral (3 days) and the feature update deferral (5 days), then assign the ring to `SG-All-Staff`.

## Evidence

![Win-Updates-Standard review page](images/update-ring.png)

The screenshot is the **Review + create** page of the ring.

| Item | Value shown |
| --- | --- |
| Quality update deferral period | 3 days |
| Feature update deferral period | 5 days |
| Servicing channel | General Availability channel |
| Microsoft product updates | Allow |
| Windows drivers | Allow |
| Automatic update behavior | Auto install at maintenance time |
| Active hours | 8 AM to 5 PM |
| Feature update uninstall period | 10 days |
| Upgrade Windows 10 devices to latest Windows 11 | No |

## Result

The update ring sets a 3-day quality update deferral and a 5-day feature update deferral.
