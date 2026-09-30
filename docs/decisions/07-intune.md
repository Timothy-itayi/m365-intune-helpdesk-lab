# Decisions: Intune

Previous: [06-conditional-access.md](06-conditional-access.md)

Phase note: [05-intune.md](../phases/05-intune.md)

Evidence: [evidence/05-intune](../../evidence/05-intune/00-mdm-user-scope.md)

## Decisions

- Set the MDM user scope to All, so any user's device that joins Entra can enrol in Intune. The tutorial allowed All or Some with `SG-All-Staff` ([00-mdm-user-scope.md](../../evidence/05-intune/00-mdm-user-scope.md)).
- Created four items and assigned each to `SG-All-Staff`. They only take effect once a device enrols in Phase 6, so the configuration itself is the evidence.
  - `Win-Compliance-Baseline`, a Windows compliance policy, with the noncompliance action set to mark the device noncompliant immediately ([01-compliance-policy.md](../../evidence/05-intune/01-compliance-policy.md)).
  - `Win-Config-Baseline`, a Settings catalog profile ([02-config-profile.md](../../evidence/05-intune/02-config-profile.md)).
  - `Win-Updates-Standard`, an update ring with a 3-day quality update deferral ([03-update-ring.md](../../evidence/05-intune/03-update-ring.md)).
  - Windows Terminal, a Microsoft Store app, Required, install behaviour User ([04-app-assignment.md](../../evidence/05-intune/04-app-assignment.md)).
- Used one group, `SG-All-Staff`, for every assignment. It is the same group CA03 targets ([06-conditional-access.md](06-conditional-access.md)), so compliance results will feed that policy in Phase 6.

## Trade-offs

- MDM scope All puts every user's devices in reach of Intune, including admins. Scoping to `SG-All-Staff` would have limited that. `SG-All-Staff` is a manually maintained group ([05-scripts.md](05-scripts.md)), so a new starter who isn't added by hand gets the enrolment scope but no policies.
- The evidence does not match the plan in three places. These are open, not decisions:
  - The config profile screenshot shows Allow Windows Consumer Features as **Allow**, and an empty assignment list.
  - The update ring screenshot shows a 5-day **feature update deferral**, with deadline settings Not configured. There is no 5-day deadline.
  - The compliance policy screenshot does not show BitLocker, Secure Boot or Firewall.
- Three of the five screenshots (config profile, update ring, app) are the Review + create page, taken before pressing Create. They show intent, not created objects.
- The Phase 5 screenshots show the break-glass account signed in. That account is used in the private window for reading the Entra sign-in logs, and the Intune pages were captured in the same session. That is a departure from the Phase 3 choice to script as the admin ([05-scripts.md](05-scripts.md)), but the break-glass sign-ins are deliberate and have a stated reason. The cost is that break-glass sign-ins will show up as routine activity, so the "alert when break-glass signs in" idea in [01-tenant.md](../phases/01-tenant.md) would need to allow for this.
- Portal changes are not in `logs/actions.csv`. The evidence and this log are the record.
