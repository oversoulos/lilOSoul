# fastfetch — Manual

## What this is
fastfetch — a system info tool that prints a summary (OS, kernel, CPU, GPU, uptime, etc) to the terminal, often with ASCII art.

## Why it's here
A quick system snapshot when opening a new terminal, or to sanity-check what hardware/OS info the system reports.

## Dependencies
- None beyond the package.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.fastfetch` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
