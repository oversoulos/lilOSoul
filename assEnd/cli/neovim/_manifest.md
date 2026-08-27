# neovim — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.neovim`

## How to add to it
Add new settings inside `config.nix` under `options.programs.neovim`, then set
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
defaultEditor = true here sets $EDITOR to nvim. If VSCode's defaultEditor is ever also turned on, the two will fight over which one $EDITOR actually points to — worth deciding once, not something changed here.
