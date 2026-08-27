# tmux — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.tmux`

## How to add to it
Add new settings inside `config.nix` under `options.programs.tmux`, then set
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
This folder previously held a nested zoxide/default.nix (a directory-jump tool, unrelated to tmux) instead of any real tmux config — that mismatch is why you were asked. Per your call, zoxide has been scrapped entirely (not migrated anywhere), and this is a freshly built, genuine tmux module.
