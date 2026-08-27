# htop — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.htop`

## How to add to it
Add new settings inside `config.nix` under `options.programs.htop`, then set
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
Overlaps with mission-center (GUI) and btop (also terminal) — three system monitors total across gui/cli. Not a conflict, just multiple tools doing similar jobs at different levels of detail.
