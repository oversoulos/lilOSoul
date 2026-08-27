# nano — Manual

## What this is
Nano — a simple, beginner-friendly terminal text editor. Kept here as a fallback/backup editor.

## Why it's here
For quick edits when Neovim feels like overkill, or as a safety net if Neovim config ever breaks.

## Dependencies
- None beyond the package.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.nano` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
