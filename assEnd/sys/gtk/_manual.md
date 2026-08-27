# gtk — Manual

## What this is
System-wide GTK theming — sets the GTK theme, icon theme, cursor theme, and default font used by GTK-based apps (Thunar, most GUI dialogs).

## Why it's here
Consistent look across GTK apps — currently defaults to a Dracula/Papirus/Bibata combo, which lines up with the Dracula-style colors already used in mako's default settings.

## Dependencies
- The theme/icon/cursor/font packages themselves (dracula-theme, papirus-icon-theme, bibata-cursors, noto-fonts) — all pulled in automatically by this module.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.gtk` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
