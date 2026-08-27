# mako — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.mako`

## How to add to it
Add new settings inside `config.nix` under `options.programs.mako`, then set the
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
The default settings block hardcodes a Dracula-style color scheme (#282a34/#f8f8f2/#bd93f9). Once matugen/wallust theming is wired up, these values are the ones that theming engine should be overriding — worth flagging so the two don't fight each other.
