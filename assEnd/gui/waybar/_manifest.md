# waybar — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.waybar`

## How to add to it
Add new settings inside `config.nix` under `options.programs.waybar`, then set the
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
Waybar and DankMaterialShell/Quickshell can both provide a status bar. Since Quickshell/DMS is your locked desktop shell, decide whether Waybar is a backup/alternative bar or genuinely meant to run alongside it — running two status bars at once usually isn't the goal. Not changing this without you confirming which one you want as the active bar.
