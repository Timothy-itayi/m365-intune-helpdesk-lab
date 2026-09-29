# 3.8 Ben Is Blocked

Previous: [07-leaver-output.md](07-leaver-output.md)

Decision: [05-scripts.md](../../docs/decisions/05-scripts.md)

## Steps

1. In the Microsoft 365 admin center, open Users > Active users > Ben Carter and check the sign-in status.
2. In a private window, try to sign in as Ben. Record the message.

## Evidence

Ben Carter's account page in the Microsoft 365 admin center:

![Sign-in blocked in the admin center](images/admin-center-signin-blocked-ben-carter.png)

The page shows **Sign-in blocked** in red, with an "Unblock sign-in" action.

Sign-in attempt as Ben in a private window:

![Sign-in attempt](images/ben-carter-locked-azure.png)

The page says: "Your account has been locked. Contact your support person to unlock it, then try again."

An earlier attempt showed "Your account or password is incorrect", which is the message a wrong password gives. Its screenshot is no longer in the repo. Ben's password was a random temporary one that was shown once and never used, so that attempt may have been a wrong password.

## What this proves

- The admin center screenshot proves the account is blocked.
- The "account has been locked" message is different from the wrong-password message, so it is the sign-in error for the blocked account. This screenshot is the sign-in evidence for Ben.
