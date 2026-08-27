# rofi — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.rofi`

## How to add to it
Add new settings inside `config.nix` under `options.programs.rofi`, then set the
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
You already have fuzzel (atomic/cli) doing app launching. Rofi does more (window switching, custom modes, more theming) but if fuzzel already covers what you need, running both is redundant — worth deciding which one is your actual launcher rather than having two bound to different keys by accident.
