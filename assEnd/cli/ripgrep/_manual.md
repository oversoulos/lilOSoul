# ripgrep — Manual

## What this is
ripgrep (rg) — a very fast recursive text search tool, like `grep` but respects .gitignore by default and is dramatically faster on large codebases.

## Why it's here
Searching file contents across a project quickly — used directly, and also pulled in as a dependency by other tools like Neovim's LSP tooling.

## Dependencies
- None beyond the package.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.ripgrep` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
