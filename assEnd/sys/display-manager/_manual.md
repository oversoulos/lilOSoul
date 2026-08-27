# display-manager — Manual

## What this is
SDDM — a more full-featured graphical display/login manager (themeable, Wayland-capable), as an alternative to greetd.

## Why it's here
A heavier but more polished login screen option than greetd, if you want theming/customization greetd doesn't offer.

## Dependencies
- A desktop session for SDDM to launch into (not hardcoded here — set via NixOS's usual session selection at the login screen).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.displayManager` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
