# yazi — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.yazi`

## How to add to it
Add new settings inside `config.nix` under `options.programs.yazi`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` — that
file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/cli module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/cli/default.nix` imports this module's folder directly. `atomic/cli`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
This module already pulls in zoxide as a dependency package for fast directory jumping inside yazi. That's separate from the old atomic/cli/tmux/zoxide/default.nix module, which you asked to scrap — this yazi-bundled zoxide package stays since it's part of yazi's own preview/navigation dependencies, not a standalone zoxide module.
