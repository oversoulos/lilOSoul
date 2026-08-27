# your-spotify — Manual

## What this is
Your-Spotify — a self-hosted web dashboard that tracks and visualizes your Spotify listening stats over time (like a self-hosted Spotify Wrapped).

## Why it's here
Personal listening analytics that stay on your own machine instead of relying on Spotify's own yearly wrap-up.

## Dependencies
- A registered Spotify Developer application (to get a client ID/secret)
- A running network connection for it to poll the Spotify API
- systemd (this runs as a background service, not a launched app)

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `services.your-spotify` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
