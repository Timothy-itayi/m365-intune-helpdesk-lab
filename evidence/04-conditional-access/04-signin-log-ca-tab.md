# 4.3 Sign-in Log: Conditional Access Details for Ava

Previous: [03-ava-mfa-prompt.md](03-ava-mfa-prompt.md)

Decision: [06-conditional-access.md](../../docs/decisions/06-conditional-access.md)

## Steps

Entra admin center > Monitoring & health > Sign-in logs. Open Ava's sign-in, select the Conditional Access tab, then open a policy.

Expected: CA01 listed with a Report-only result such as Success, Failure or Not applied, showing what would have happened if the policy were enforced.

## Evidence

![Conditional Access policy details for Ava's sign-in](images/ava-ca-policy-details.png)

| Field | Value |
| --- | --- |
| Policy | Require multifactor authentication for all users |
| Policy state | Enabled |
| Result | Success |
| User | Ava Nguyen: Matched |
| Resource | IrisSelectionFrontDoor: Matched |
| Device platform | MacOs |
| Client app | Browser |
| Device | Unknown |
| Network | Glen Iris, AU (IP address in the screenshot) |
| Grant controls | Satisfied |

The conditions listed (platform, network, client app, device, user risk, authentication flows) are all marked "Not configured", meaning the policy does not filter on them.

## What this proves, and what it doesn't

- An MFA policy applied to Ava's sign-in and its grant control was satisfied. That fits the MFA prompt in [03-ava-mfa-prompt.md](03-ava-mfa-prompt.md).
- **The state is Enabled, not Report-only.** The tutorial expected a Report-only result from CA01. This policy was enforcing.
- **The name does not match CA01.** The pane reads "Require multifactor authentication for all users". CA01 is named `CA01 Require MFA - All users`, and the Microsoft-managed policy in the list is named "Multifactor authentication for all users" ([02-policy-list-report-only.md](02-policy-list-report-only.md)). The name matches neither exactly. If CA01 had been switched On, I would expect the pane to show CA01's own name, so this is more likely a Microsoft-managed policy. That is not verified.
- Either way, this screenshot cannot be used as evidence that CA01 works. It is evidence that some MFA policy applied to Ava.
- The Report-only stage the tutorial wanted, where CA01 reports what it would have done, is not captured.
- The resource is shown as `IrisSelectionFrontDoor`, not Office 365. I don't know what that resource is, so I am not naming it.
- Only one policy pane was captured, not the full Conditional Access tab listing every policy that was evaluated. That list would show whether CA01 and CA02 were evaluated too, and with what result.
- The screenshot shows Ava's IP address (IPv6) and suburb. See the privacy note in [04-conditional-access.md](../../docs/phases/04-conditional-access.md).
