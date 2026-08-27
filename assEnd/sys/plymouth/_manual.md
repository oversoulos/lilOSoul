# plymouth — Manual

## What this is
Plymouth — the graphical boot splash screen shown while the system starts up, before you reach the login screen.

## Why it's here
A polished boot screen instead of raw text-scroll boot logs.

## Dependencies
- boot.initrd.systemd.enable is turned on automatically by this module — a real change to how your initrd boots, not just cosmetic.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.plymouth` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
