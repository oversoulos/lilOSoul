# fzf — Manual

## What this is
fzf — a general-purpose fuzzy finder for the terminal: pipe any list into it (files, command history, git branches) and interactively filter it.

## Why it's here
Powers fast fuzzy searching inside the shell — e.g. Ctrl+R history search becomes fuzzy-searchable once zsh integration is on.

## Dependencies
- A shell with enableZshIntegration/enableBashIntegration turned on to get the keybindings (Ctrl+R, Ctrl+T) — otherwise fzf is just installed but not wired into your shell.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.fzf` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
