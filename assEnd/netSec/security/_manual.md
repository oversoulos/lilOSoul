# security — Manual

## What this is
A bundled "network security toolkit" module — a grab-bag that can install a set of network/security CLI tools (wireguard-tools, mullvad-vpn, tailscale, nmap, tcpdump, curl, aria2, git-lfs) and optionally toggle Tailscale and Privoxy.

## Why it's here
A single switch to pull in a batch of general network/security tooling at once, rather than adding each tool individually.

## Dependencies
- Overlaps with atomic/sys/tailscale.nix — enabling both this module's `tailscale` option and the dedicated sys/tailscale module both ultimately flip the same `services.tailscale.enable` switch, which is harmless (both just say "on") but redundant.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `molecular.security` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/netSec/default.nix`'s imports list, and that
  `atomic/netSec` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
