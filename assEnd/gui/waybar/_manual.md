# waybar — Manual

## What this is
Waybar — a customizable status bar for Wayland compositors (workspaces, clock, system tray, etc).

## Why it's here
The top/bottom bar showing workspace indicators, clock, and system info under Hyprland.

## Dependencies
- A Wayland compositor to attach the bar to.
- Fonts/icons (Nerd Font) for module glyphs to render correctly.

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.waybar` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
