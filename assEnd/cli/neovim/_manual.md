# neovim — Manual

## What this is
Neovim — your primary code/text editor, with LSP servers, formatters, and plugins configured through Nix.

## Why it's here
Your main terminal-based editor for actual development work (as opposed to nano, which is just a fallback).

## Dependencies
- Python 3 and Node.js providers (both on by default here) if plugins/LSPs need them.
- The LSP servers/formatters listed in extraPackages (gopls, lua-language-server, nil, nixfmt, ripgrep, fd, tree-sitter) — several of these double up with atomic/cli's own fd and ripgrep modules.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.neovim` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
