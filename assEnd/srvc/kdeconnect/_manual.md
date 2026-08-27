# kdeconnect — Manual

## What this is
KDE Connect — integrates your phone and this computer over the local network: notifications, file sharing, clipboard sync, media control, and remote input.

## Why it's here
Bridges your phone and this machine without cables or cloud services — see phone notifications on desktop, send files either direction, control media playback.

## Dependencies
- The KDE Connect app installed on your phone, connected to the same local network as this machine.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.kdeconnect` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/srvc/default.nix`'s imports list, and that
  `atomic/srvc` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
