# greeter — Manual

## What this is
greetd — a minimal, lightweight login manager, configured here with the regreet graphical greeter, defaulting to launching Hyprland.

## Why it's here
This is what shows the login screen and starts your Hyprland session when the machine boots.

## Dependencies
- A desktop session to launch (Hyprland, set as defaultSession).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.greetd` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
