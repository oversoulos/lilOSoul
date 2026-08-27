# fuzzel — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.fuzzel`

## How to add to it
Add new settings inside `config.nix` under `options.programs.fuzzel`, then set
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
atomic/gui/rofi does the same job (app launcher). If both are enabled you have two launchers bound to different keys — worth deciding which is your actual daily launcher, not changed here without you saying so.
