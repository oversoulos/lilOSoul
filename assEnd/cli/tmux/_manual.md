# tmux — Manual

## What this is
Tmux — a terminal multiplexer: run and organize multiple terminal sessions/panes/windows inside one terminal window, and keep sessions alive after you disconnect.

## Why it's here
Useful for running long processes (builds, servers, AI model downloads) that need to keep going even if you close the terminal window, and for splitting one terminal into multiple panes without needing separate windows.

## Dependencies
- A terminal emulator to run inside (Ghostty here).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.tmux` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
