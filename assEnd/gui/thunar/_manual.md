# thunar — Manual

## What this is
Thunar — the XFCE file manager, with the archive plugin (zip/tar handling) included by default.

## Why it's here
Graphical file browsing/management, since a terminal-only workflow (yazi) isn't always convenient for drag-and-drop or visual browsing.

## Dependencies
- dbus (declared automatically via services.dbus.packages)
- xfconf (XFCE's settings-storage daemon, auto-enabled by this module)

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.thunar` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
