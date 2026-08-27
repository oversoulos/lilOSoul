# tailscale — Manual

## What this is
Tailscale — a mesh VPN that securely connects your devices to each other directly, without manually configuring firewall/port-forwarding rules.

## Why it's here
Remote access between your own devices (e.g. reaching this machine from elsewhere) without exposing services to the open internet.

## Dependencies
- A Tailscale account to authenticate the device against (done via `tailscale up`, not part of this config).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.tailscale` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
