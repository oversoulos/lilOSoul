# cloudflared — Manual

## What this is
Cloudflare Tunnel client — creates an outbound-only encrypted tunnel to Cloudflare's network, letting you expose a local service to the internet without opening any inbound firewall ports.

## Why it's here
Safer way to expose something running on this machine (e.g. a self-hosted app) to the internet than port-forwarding, since no inbound ports need to be opened on your router/firewall at all.

## Dependencies
- A Cloudflare account with a Tunnel already created (tunnelId) and its credentials file downloaded from the Cloudflare dashboard.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.cloudflared` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/netSec/default.nix`'s imports list, and that
  `atomic/netSec` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
