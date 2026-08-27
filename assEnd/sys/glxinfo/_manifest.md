# glxinfo — Manifest

**Category:** atomic / sys
**Option namespace:** `programs.glxinfo`

## How to add to it
Add new settings inside `config.nix` under `options.programs.glxinfo`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` — that
file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/sys module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/sys/default.nix` imports this module's folder directly. `atomic/sys`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
None currently noted.
