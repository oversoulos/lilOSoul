# foot — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.foot`

## How to add to it
Add new settings inside `config.nix` under `options.programs.foot`, then set the
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
Since Ghostty is your locked-in daily terminal, foot's role here is narrowly the dropdown/quick-access terminal, not a replacement. Worth double-checking you actually want two terminal apps installed, or whether Ghostty alone (with a scratch/dropdown Hyprland rule) could cover this instead — that's your call, not something to change without you saying so.
