# Decisions: PowerShell Docker Image

Previous: [01.md](01.md)

- Incident: [Docker build failure on Apple Silicon](../incidents/01-setup.md#incident-docker-build-failure-on-apple-silicon)
- Evidence: [PowerShell Docker Image Setup](../../evidence/00-setup/01.md)

## Decisions

- Containerised PowerShell and the Microsoft Graph modules so the lab scripts run the same way on any machine.
- Dropped `powershell:latest` with `--platform=linux/amd64`. `latest` has no `linux/arm64` image, and the emulated .NET runtime crashed with exit code 133.
- Used the native arm64 base `mcr.microsoft.com/powershell:lts-azurelinux-3.0-arm64`.
- Pinned an LTS tag instead of `latest` so rebuilds are repeatable.
- Installed only the five Graph submodules the lab needs, not the full `Microsoft.Graph` module.
- Set `$ErrorActionPreference = "Stop"` so a failed module install fails the build.
- Mounted the repo at `/work` at run time instead of copying files into the image.

## Trade-offs

- The arm64-only tag will not build on x86 hosts or CI runners. Add a build argument for the tag if that is ever needed.

## Status

Proposed. The image builds and runs natively, but Docker labels it `linux/amd64`. It stays Proposed until a rebuild with `--platform=linux/arm64` reports `linux/arm64`. Details are in the evidence report.
