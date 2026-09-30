# Decisions: Intune

Previous: [06-conditional-access.md](06-conditional-access.md)

Phase note: [05-intune.md](../phases/05-intune.md)

Evidence: [evidence/05-intune](../../evidence/05-intune/00-mdm-user-scope.md)

## Decisions

- Set the MDM user scope to All, so any user's device that joins Entra can enrol in Intune. The tutorial allowed All or Some with `SG-All-Staff` ([00-mdm-user-scope.md](../../evidence/05-intune/00-mdm-user-scope.md)).
- Created four items and assigned each to `SG-All-Staff`. They only take effect once a device enrols. Phase 6 was skipped ([08-device-enrolment-skipped.md](08-device-enrolment-skipped.md)), so none of them has taken effect, and the configuration itself is the only evidence.
  - `Win-Compliance-Baseline`, a Windows compliance policy, with the noncompliance action set to mark the device noncompliant immediately ([01-compliance-policy.md](../../evidence/05-intune/01-compliance-policy.md)).
  - `Win-Config-Baseline`, a Settings catalog profile ([02-config-profile.md](../../evidence/05-intune/02-config-profile.md)).
  - `Win-Updates-Standard`, an update ring with a 3-day quality update deferral ([03-update-ring.md](../../evidence/05-intune/03-update-ring.md)).
  - Windows Terminal, a Microsoft Store app, Required, install behaviour User ([04-app-assignment.md](../../evidence/05-intune/04-app-assignment.md)).
- Used one group, `SG-All-Staff`, for every assignment. It is the same group CA03 targets ([06-conditional-access.md](06-conditional-access.md)), so compliance results would have fed that policy. With no device, they never will.

## Trade-offs

- MDM scope All puts every user's devices in reach of Intune, including admins. Scoping to `SG-All-Staff` would have limited that. `SG-All-Staff` is a manually maintained group ([05-scripts.md](05-scripts.md)), so a new starter who isn't added by hand gets the enrolment scope but no policies.
- The evidence does not match the plan in three places. These are open, not decisions:
  - The saved config profile shows Allow Windows Consumer Features as **Allow**. Its assignment is not shown, and is empty on the review page.
  - The update ring screenshot shows a 5-day **feature update deferral**, with deadline settings Not configured. There is no 5-day deadline.
  - The compliance policy screenshots do not show BitLocker, Secure Boot or Firewall. They do show a 1-minute inactivity limit, 41-day expiry and 5 remembered passwords, which the tutorial did not ask for.
- The update ring and app are shown only on their Review + create pages. They were created straight after, but the evidence doesn't show the saved objects. The config profile is shown as a saved object, and the MDM scope is taken as saved.
- The Phase 5 screenshots show the break-glass account signed in. That account is used in the private window for reading the Entra sign-in logs, and the Intune pages were captured in the same session. That is a departure from the Phase 3 choice to script as the admin ([05-scripts.md](05-scripts.md)), but the break-glass sign-ins are deliberate and have a stated reason. The cost is that break-glass sign-ins will show up as routine activity, so the "alert when break-glass signs in" idea in [01-tenant.md](../phases/01-tenant.md) would need to allow for this.
- Portal changes are not in `logs/actions.csv`. The evidence and this log are the record.
