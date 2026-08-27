# slurp — Manifest

**Category:** atomic / sys
**Option namespace:** `programs.slurp`

## How to add to it
Add new settings inside `config.nix` under `options.programs.slurp`, then set
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
slurp alone only selects a region; it needs a capture tool (commonly grim) to actually save an image. grim isn't present anywhere in this dump — screenshots won't fully work until something like it is added as its own module.
