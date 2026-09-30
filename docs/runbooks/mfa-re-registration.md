# Runbook: User can't complete MFA (lost or replaced phone)

Previous: [06-device.md](../phases/06-device.md)

**Applies to:** Standard users  |  **Status:** Drafted, not yet run against a real incident  |  **Last tested:** Never

This is the only runbook in the repo. Runbooks and tickets are not the focus of this lab ([09-scope.md](../decisions/09-scope.md)).

The steps come from the Phase 7 tutorial. The screenshots below are from a normal MFA sign-in in [Phase 4](../phases/04-conditional-access.md), shown as examples of what each view looks like. They are not from a lost-phone incident, and none of them shows the fix.

## Symptoms

The user can enter a password but cannot approve the sign-in prompt or supply the MFA code. They are blocked from Microsoft 365.

Example of what the user sees, the "Approve sign in request" page with a number to match in Authenticator:

![Approve sign in request](../../evidence/04-conditional-access/images/ava-mfa-approve-prompt.png)

If the phone is lost or replaced, the user is stuck on this page.

## Checks (in order)

1. Verify the user's identity using the company's process, such as a call-back to the number on file or manager approval. Do this before changing anything, so the reset can't be used by someone impersonating the user.
2. Entra admin center > Monitoring & health > Sign-in logs. Open the user's latest sign-in and confirm the failure is at the MFA step, and which Conditional Access policy applied.
3. Confirm the account is enabled and licensed, so the fault is not at the account level.
4. Entra > Users > the user > Authentication methods. Check which methods are registered.

Example of the diagnostic view, a sign-in log entry with the Conditional Access policy details. In the example the policy applied and its grant control was satisfied. In an incident you would expect the grant control not to be satisfied:

![Conditional Access policy details in the sign-in log](../../evidence/04-conditional-access/images/ava-ca-policy-details.png)

## Fix

1. Entra > Users > the user > Authentication methods > **Require re-register multifactor authentication**.
2. Revoke sessions: Users > the user > **Revoke sessions**.
3. Ask the user to sign in and register Authenticator on the new phone.

No screenshot of these steps exists yet. Capture the Authentication methods page and the re-register action the first time this runbook is used.

## Verify it worked

The sign-in log shows a successful sign-in with MFA satisfied. The example above, with a Success result and the grant control Satisfied, is what that looks like.

## Escalate when

- Identity can't be verified.
- The account is flagged risky, or shows sign-ins from unexpected locations.

## Notes

- The Conditional Access policy in the example is an MFA policy, but it is not confirmed to be CA01 ([04-signin-log-ca-tab.md](../../evidence/04-conditional-access/04-signin-log-ca-tab.md)). Read the policy name in the log, don't assume.
- The example sign-in log screenshot shows the user's IP address and suburb. Blur these before publishing.
- Prevention: encourage users to register two methods, and add a step to the phone-replacement checklist.

## Related tickets

None yet. No MFA lockout incident has been run.
