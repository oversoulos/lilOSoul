# zsh — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.zsh`

## How to add to it
Add new settings inside `config.nix` under `options.programs.zsh`, then set
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
Several other cli modules (starship, fzf) have enableZshIntegration options that only do anything if this zsh module is actually enabled — worth keeping zsh's enable state in mind when troubleshooting why another module's shell integration doesn't seem to be working.
