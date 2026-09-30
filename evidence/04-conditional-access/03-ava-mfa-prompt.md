# 4.3 Test as a Normal User: Ava's MFA Prompt

Previous: [02-policy-list-report-only.md](02-policy-list-report-only.md)

Decision: [06-conditional-access.md](../../docs/decisions/06-conditional-access.md)

## Steps

1. Install Microsoft Authenticator on a phone.
2. In a private browser window, go to `https://portal.office.com` and sign in as `ava.nguyen@helpdeskco123.onmicrosoft.com` with her temporary password.
3. Set a new password when asked.
4. Follow the prompts to register Authenticator on the phone.

## Evidence

![Approve sign in request for Ava](images/ava-mfa-approve-prompt.png)

The page reads "Approve sign in request" for `ava.nguyen@helpdeskco123.onmicrosoft.com`. It tells her to open the Authenticator app and approve the request, and shows the number **67** to enter in the app (number matching).

## Result

Ava has Authenticator registered and her sign-in was challenged for MFA. The sign-in log entry is in [04-signin-log-ca-tab.md](04-signin-log-ca-tab.md).
