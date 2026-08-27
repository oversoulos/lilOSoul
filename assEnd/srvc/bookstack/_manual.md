# bookstack — Manual

## What this is
Bookstack — a self-hosted wiki/documentation platform (PHP + MySQL/Postgres based), served here via nginx and PHP-FPM.

## Why it's here
A place to write and organize your own documentation/notes as a proper wiki, separate from Obsidian's local-file approach — useful if you want something browsable/shareable over a network rather than a personal vault.

## Dependencies
- A database (MySQL/MariaDB or PostgreSQL) is required by Bookstack itself but is NOT configured anywhere in this module — services.mysql or services.postgresql needs to be set up separately with a matching database for Bookstack to actually work.
- nginx and phpfpm are both auto-enabled by this module.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.bookstack` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/srvc/default.nix`'s imports list, and that
  `atomic/srvc` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
