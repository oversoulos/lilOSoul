# thunar — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.thunar`

## How to add to it
Add new settings inside `config.nix` under `options.programs.thunar`, then set the
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
Overlaps with atomic/cli/yazi (terminal file manager) — Thunar is the GUI counterpart, useful when you want visual thumbnails or drag-and-drop instead of keyboard navigation.
