# slurp — Manual

## What this is
slurp — a Wayland tool for selecting a screen region with the mouse (drag a box), typically piped into a screenshot tool.

## Why it's here
The 'select an area of the screen' piece of a screenshot workflow — it doesn't take the screenshot itself, just outputs the coordinates of what you selected.

## Dependencies
- A screenshot-capture tool to pipe slurp's output into (e.g. grim) — not included in this dump, so screenshots won't fully work until one is added.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.slurp` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
