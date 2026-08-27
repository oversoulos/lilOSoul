# syncthing — Manual

## What this is
Syncthing — continuous, decentralized, device-to-device file synchronization with no central server involved.

## Why it's here
Matches your stated preference for direct device-to-device sync over centralized services like GitHub or Nextcloud for moving files between machines.

## Dependencies
- Devices must exchange IDs and approve each other before syncing starts (done through Syncthing's own web UI, not this config).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.syncthing` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/srvc/default.nix`'s imports list, and that
  `atomic/srvc` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
