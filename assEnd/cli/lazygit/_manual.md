# lazygit — Manual

## What this is
Lazygit — a terminal UI for git: stage files, view diffs, commit, branch, and push, all without typing raw git commands.

## Why it's here
A visual layer over git that's still fully keyboard-driven and stays in the terminal — much faster than typing `git status`/`git diff`/`git add` repeatedly.

## Dependencies
- git itself must be installed and configured (see the git module) — lazygit is a UI on top of it, not a replacement.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.lazygit` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
