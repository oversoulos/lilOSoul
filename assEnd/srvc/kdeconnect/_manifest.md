# kdeconnect — Manifest

**Category:** atomic / srvc
**Option namespace:** `services.kdeconnect`

## How to add to it
Add new settings inside `config.nix` under `options.services.kdeconnect`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/srvc module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/srvc/default.nix` imports this module's folder directly. `atomic/srvc`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
None currently noted.
