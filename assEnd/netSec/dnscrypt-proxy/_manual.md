# dnscrypt-proxy — Manual

## What this is
DNSCrypt-proxy — encrypts DNS queries leaving this machine, preventing your ISP or anyone on the network from seeing plaintext DNS lookups (which sites you're resolving).

## Why it's here
Privacy on DNS lookups specifically — separate from a VPN (which encrypts all traffic); this only covers DNS resolution.

## Dependencies
- Sets networking.nameservers to 127.0.0.1, meaning dnscrypt-proxy itself becomes your system's DNS resolver — if this service isn't running, DNS resolution breaks system-wide.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.dnscrypt-proxy` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/netSec/default.nix`'s imports list, and that
  `atomic/netSec` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
