# zsh — Manual

## What this is
Zsh — the Z shell, your interactive login shell, with completion, autosuggestions, and syntax highlighting.

## Why it's here
This is the shell everything else (starship, eza, zoxide integrations, aliases) attaches to — the base of your whole terminal experience.

## Dependencies
- oh-my-zsh (optional, off by default here) if ohMyZsh.enable is turned on.
- Any tool with enableZshIntegration = true (starship, fzf, etc.) depends on zsh being enabled first.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.zsh` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
