# foot — Manual

## What this is
Foot — a fast, minimal Wayland-native terminal. This module is set up specifically as a dropdown/quake-style quick terminal, separate from your main terminal.

## Why it's here
Ghostty is the daily-driver terminal; foot here is scoped as a secondary quick-access terminal (drop-down style) for fast one-off commands.

## Dependencies
- A Wayland compositor with a keybind wired up to toggle the dropdown (the keybind itself lives in Hyprland config, not here).

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.foot` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
