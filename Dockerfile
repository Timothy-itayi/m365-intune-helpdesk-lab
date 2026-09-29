FROM mcr.microsoft.com/powershell:lts-azurelinux-3.0-arm64

RUN pwsh -NoProfile -Command \
    '$ErrorActionPreference = "Stop"; \
     Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
     $modules = @( \
       "Microsoft.Graph.Authentication", \
       "Microsoft.Graph.Users", \
       "Microsoft.Graph.Users.Actions", \
       "Microsoft.Graph.Groups", \
       "Microsoft.Graph.Identity.DirectoryManagement" \
     ); \
     foreach ($module in $modules) { \
       Write-Host "Installing $module"; \
       Install-Module $module -Scope AllUsers -Repository PSGallery -Force \
     }'

WORKDIR /work