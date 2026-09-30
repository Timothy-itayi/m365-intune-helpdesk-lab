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

## Result

The admin center shows Ben's account as blocked, and his sign-in fails with "Your account has been locked".
