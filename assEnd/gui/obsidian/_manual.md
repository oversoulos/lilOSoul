# obsidian — Manual

## What this is
Obsidian — a local-first markdown note-taking app with linking, graph view, and plugin support.

## Why it's here
Your primary knowledge hub per your existing setup (Dataview, Templater, Python coursework notes). This module lets you predefine vault paths so they exist system-wide instead of manually re-adding them per machine.

## Dependencies
- None beyond the package. Plugins (Dataview, Templater) install inside Obsidian itself, not through this module.

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.obsidian` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
