# gtk — Manifest

**Category:** atomic / sys
**Option namespace:** `programs.gtk`

## How to add to it
Add new settings inside `config.nix` under `options.programs.gtk`, then set
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
Once matugen/wallust wallpaper-driven theming is wired up, it will likely want to override these same theme/icon/cursor values dynamically — worth keeping in mind so the two don't fight over which one 'wins' the theme.
