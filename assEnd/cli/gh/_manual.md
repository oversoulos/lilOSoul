# gh — Manual

## What this is
The official GitHub CLI — create/view PRs and issues, clone repos, and auth to GitHub from the terminal.

## Why it's here
Lets you do GitHub actions (PR review, issue triage, repo clone) without opening a browser — pairs with lazygit for a fully terminal-based git workflow.

## Dependencies
- A GitHub account to authenticate against (`gh auth login`, done once, not part of this config).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.gh` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
