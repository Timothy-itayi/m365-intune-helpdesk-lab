# 5.5 Deploy an App

Previous: [03-update-ring.md](03-update-ring.md)

Decision: [07-intune.md](../../docs/decisions/07-intune.md)

## Steps

Intune admin center > Apps > Windows > Create > Microsoft Store app (new). Search for a free app, then set the assignment to Required for `SG-All-Staff`.

## Evidence

![Windows Terminal assignment](images/app-assignment.png)

The screenshot is the **Review + create** page of the Add App wizard, before the app was created.

| Item | Value shown |
| --- | --- |
| App | Windows Terminal, Microsoft Corporation |
| Package identifier | `9N0DX20HK701` |
| Installer type | UWP |
| Install behavior | User |
| Required | `SG-All-Staff`, Active, no filter |
| Available for enrolled devices | Empty |
| Uninstall | Empty |

## What this proves, and what it doesn't

- The assignment is set as Required for `SG-All-Staff`, which is what the tutorial asked for.
- It is the page before Create, so it does not prove the app exists in the app list.
- Install behavior is User, so the app installs for the signed-in user. Nothing installs until a device is enrolled in Phase 6.
