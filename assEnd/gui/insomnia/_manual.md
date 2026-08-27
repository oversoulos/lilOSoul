# insomnia — Manual

## What this is
Insomnia — a desktop REST/GraphQL API client for building, testing, and debugging API requests (similar to Postman).

## Why it's here
Useful for testing your own APIs or third-party APIs while developing — sending requests, inspecting responses, saving request collections.

## Dependencies
- None beyond the package. Optional: a Nerd Font for the UI icons if you want them to render fully.

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.insomnia` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
