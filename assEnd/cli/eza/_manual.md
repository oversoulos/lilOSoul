# eza — Manual

## What this is
Eza — a modern replacement for `ls` with icons, colors, and git status shown directly in directory listings.

## Why it's here
Nicer, more informative directory listings than plain `ls` — aliases here (ls, l, la, ll, tree) mean you keep typing familiar commands but get eza's output.

## Dependencies
- A Nerd Font installed for icons to render correctly (icons = true by default).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.eza` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
