# dbeaver — Manual

## What this is
DBeaver — a universal graphical database client (supports Postgres, MySQL, SQLite, and many others via drivers).

## Why it's here
Connect to and browse/query databases without a CLI tool, useful for anything you build that stores data in a real database.

## Dependencies
- Relevant JDBC drivers are usually auto-downloaded by DBeaver itself on first connection to a given database type.

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.dbeaver` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
