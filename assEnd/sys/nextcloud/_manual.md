# nextcloud — Manual

## What this is
Nextcloud desktop sync client — keeps a local folder synced with a Nextcloud server (self-hosted or third-party).

## Why it's here
File sync to a Nextcloud instance, if you're running or using one — separate from Syncthing, which is device-to-device sync without a central server.

## Dependencies
- A Nextcloud server/account to actually sync against (not part of this module — this is just the client).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.nextcloud-client` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
