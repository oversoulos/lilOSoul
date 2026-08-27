# git — Manual

## What this is
Git — the version control system itself (identity, aliases, global gitignore, and general config).

## Why it's here
The base git setup everything else (gh, lazygit) sits on top of — your commit identity and global preferences.

## Dependencies
- None beyond the package. userName/userEmail/signingKey are all optional here — leave null until you decide what identity to commit as.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.git` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
