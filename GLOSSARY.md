# Ship OpenSEO Deployment

Self-hosted OpenSEO instance operated on Cloudflare under a custom domain while staying strictly aligned with the upstream repository.

## Language

**Ship OpenSEO**:
Our self-hosted fork and operational wrapper (`WilderLinDev/ship-openseo`) around the upstream OpenSEO project.
_Avoid_: OpenSEO Cloud, hosted OpenSEO

**Upstream**:
The official `every-app/open-seo` repository from which application updates are pulled without modifying tracked upstream files.
_Avoid_: Origin, base repo

**Self-Host Stack**:
The set of Cloudflare Workers and storage resources provisioned for this installation under upstream's default `open-seo-selfhost` resource naming.
_Avoid_: Preview stack, hosted prod stack

**Public Entrypoint**:
The custom domain (`openseo.lotorlabs.com`) through which users and MCP clients access this installation.
_Avoid_: Worker URL, default subdomain

**Workspace Administrator**:
The first person to register on a fresh Password-Mode installation, after which public registration closes and teammates join only by invitation.
_Avoid_: Superuser, root account

**Operator**:
The person with terminal access to this repository and its local deployment configuration who runs upgrades, deployments, and emergency account resets.
_Avoid_: Admin, end user
