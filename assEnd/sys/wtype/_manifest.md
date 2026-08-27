# wtype — Manifest

**Category:** atomic / sys
**Option namespace:** `programs.wtype`

## How to add to it
Add new settings inside `config.nix` under `options.programs.wtype`, then set
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
This module existed in the file dump but was missing from atomic/sys/default.nix's imports list -- it was written but never actually wired in. Added to the imports list as part of this pass. Worth double-checking whether nerd-dictation's setup expects wtype specifically, since that's the most likely reason this module exists here.
