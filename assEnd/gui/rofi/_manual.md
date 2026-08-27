# rofi — Manual

## What this is
Rofi — an application launcher / window switcher / dmenu replacement, themeable.

## Why it's here
Fast fuzzy-searchable app launching, similar in spirit to fuzzel (already in your cli tools) but more themeable and feature-rich (also does window switching, not just app launching).

## Dependencies
- A Wayland/X11 environment to bind a launch keybind to (the keybind itself lives in Hyprland config, not here).

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.rofi` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
