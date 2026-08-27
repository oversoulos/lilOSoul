# ewww — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.ewww`

## How to add to it
Add new settings inside `config.nix` under `options.programs.ewww`, then set the
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
You've locked in Quickshell/DankMaterialShell as the actual desktop shell engine. Eww is a separate, independent widget toolkit — install it if you want a standalone widget (like a tiny always-on-top stat display) outside of the main Quickshell setup, not as a competing shell.
