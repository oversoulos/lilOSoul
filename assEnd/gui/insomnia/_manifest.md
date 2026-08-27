# insomnia — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.insomnia`

## How to add to it
Add new settings inside `config.nix` under `options.programs.insomnia`, then set the
value you want in `module.nix`. Don't set values directly in `config.nix` — that file is
the definition, `module.nix` is the decision.

## Structure rule
Every atomic/gui module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`) sit alongside, not inside, the code.

## Where it's imported
`atomic/gui/default.nix` imports this module's folder directly. `atomic/gui` itself gets
imported by `atomic/default.nix`.

## Known issues / conflicts
This module's original file (default.nix under the `insomnia/` folder) actually contained Bitwarden's configuration, not Insomnia's — a copy/paste mismatch in the original dump. Per your instruction, this rewrite builds real Insomnia config here; the folder name and Insomnia's actual config now match. The Bitwarden functionality that used to live here is gone — if you still want Bitwarden as a module, it needs to be built fresh in its own (currently empty) `bitwarden/` folder, which you chose to skip for now.
