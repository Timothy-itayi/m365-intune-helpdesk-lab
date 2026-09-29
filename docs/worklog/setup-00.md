# Worklog: Setup

Each entry has: time spent, what I did, what happened (including errors), what I learned, and what I'd change next time. Newest phase last.

## 2026-09-29 - Setup 00: osTicket and MariaDB

Links: [evidence](../../evidence/00-setup/00.md) | [decision](../decisions/00.md) | [incident](../incidents/00-setup.md)

- Time spent: Not recorded. The incident write-up was committed at 9:27 PM.
- What I did:
  - Added an osTicket lab to the existing Operations Lab project for IT support practice.
  - Ran osTicket and MariaDB as separate services with Docker Compose.
  - Used persistent volumes for the database and attachments.
- What happened (including errors):
  - osTicket could not connect to MariaDB during install. The MariaDB log showed `Access denied for user 'osticket'@'172.18.0.3' (using password: YES)`.
  - Networking was fine, so it was an authentication problem.
  - The existing MariaDB volume held credentials from the first deployment, and MariaDB does not update them when `OST_DB_PASSWORD` changes.
  - The root password had been random (`MARIADB_RANDOM_ROOT_PASSWORD`) and I had not kept it, so I could not log in to reset the `osticket` user.
  - Fixed it by removing and recreating the MariaDB volume. The data was disposable lab data.
- What I learned:
  - An `Access denied` message means the app reached the database and authentication failed.
  - Environment variables do not overwrite credentials already stored in an existing database volume.
  - Check the container logs before assuming a network problem.
- What I'd change next time:
  - Record the MariaDB root password, or set one explicitly, instead of using a random one.
  - Keep the root password separate from the application user's password.
  - Confirm the data really is disposable before deleting a volume.

## 2026-09-29 - Setup 01: PowerShell Docker image

Links: [evidence](../../evidence/00-setup/01.md) | [decision](../decisions/02-setup.md) | [incident](../incidents/01-setup.md)

- Time spent: About 30 minutes, from the first failed build (around 9:40 PM) to the commit at 10:09 PM. This covers the build, the fix and the verification runs, not the write-ups.
- What I did:
  - Wrote a `Dockerfile` for a PowerShell environment with five Microsoft Graph modules installed (`Authentication`, `Users`, `Users.Actions`, `Groups`, `Identity.DirectoryManagement`).
  - Built and tested it on an Apple Silicon Mac with Docker Desktop.
- What happened (including errors):
  - The first build used `powershell:latest` with `--platform=linux/amd64` and failed at the `Install-Module` step with exit code 133 and `BasicBlock requested for unrecognized address`.
  - `powershell:latest` has no `linux/arm64` image, so the amd64 image was running under emulation and the .NET runtime crashed.
  - Switching to `lts-azurelinux-3.0-arm64` fixed the crash. The build finished in 1m 01s with no cached steps.
  - Verification inside the container showed PowerShell 7.4.7, all five Graph modules at 2.40.0, and both `OSArchitecture` and `ProcessArchitecture` reporting `Arm64`.
  - `docker image inspect` and the build dashboard still report `linux/amd64`, which is why Docker prints a platform warning on every run. I have not fixed this yet.
- What I learned:
  - Do not assume `latest` is multi-arch. Check the manifest.
  - `--platform=linux/amd64` on Apple Silicon means emulation, and .NET can crash under it.
  - Crashes in a translator source file (`BuilderBase.h`) point at the emulation layer, not the script.
  - `ProcessArchitecture` shows whether a process is really native, which the image label does not.
  - Zsh expands `$PSVersionTable` unless the PowerShell script is single-quoted.
- What I'd change next time:
  - Pass `--platform` explicitly and run `docker image inspect` after every build.
  - Pin a version tag, not `latest`.
  - Rebuild with `--no-cache --platform=linux/arm64` and confirm the label reads `linux/arm64`. Then mark the decision Accepted.
  - Use a build argument for the base tag if the image ever needs to build on x86.
