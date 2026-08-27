# vscode — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.vscode`

## How to add to it
Add new settings inside `config.nix` under `options.programs.vscode`, then set the
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
defaultEditor = true sets $EDITOR to `code`, which affects any CLI tool that shells out to $EDITOR (git commit messages, etc). If Neovim is meant to stay your default terminal editor, leave this option off/false so the two don't fight over $EDITOR.
