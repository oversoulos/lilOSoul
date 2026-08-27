# nntp-proxy — Manual

## What this is
An NNTP proxy — sits between local Usenet client software and an upstream Usenet provider, handling the authenticated connection so local apps don't need the provider credentials directly.

## Why it's here
Centralizes Usenet provider credentials in one place (this service) instead of every local Usenet client needing them separately.

## Dependencies
- A Usenet provider account (upstreamServer/upstreamUser/upstreamPassword) to actually proxy to.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.nntp-proxy` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/netSec/default.nix`'s imports list, and that
  `atomic/netSec` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
