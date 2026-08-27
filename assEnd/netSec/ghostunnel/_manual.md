# ghostunnel — Manual

## What this is
Ghostunnel — a mutual-TLS (mTLS) tunnel: wraps a plain, unencrypted TCP service in TLS with strict client-certificate verification, and can run multiple independent tunnels ("servers") at once, each with its own listen address, target, and access-control rules.

## Why it's here
The most capable option for exposing an internal service with strong client-certificate-based access control — more configurable than the simpler single-tunnel version this replaces, since it supports defining several named tunnels declaratively.

## Dependencies
- Certificates/keys (or a keystore file) per tunnel server, and at least one access-control rule per server (allowAll, allowCN, allowOU, allowDNS, allowURI, or disableAuthentication) — the module will fail to evaluate if a server defines none of these.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.unknown` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/netSec/default.nix`'s imports list, and that
  `atomic/netSec` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
