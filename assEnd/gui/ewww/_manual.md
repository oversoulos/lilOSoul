# ewww — Manual

## What this is
Eww (ElKowar's Wacky Widgets) — a widget system for building custom desktop widgets/bars in a Lisp-like config language.

## Why it's here
General-purpose widget engine; DankMaterialShell/Quickshell is your locked-in shell choice, so eww here is more of an available tool than the primary desktop shell.

## Dependencies
- None beyond the package to install it.

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.ewww` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
