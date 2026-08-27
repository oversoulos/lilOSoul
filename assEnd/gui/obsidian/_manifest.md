# obsidian — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.obsidian`

## How to add to it
Add new settings inside `config.nix` under `options.programs.obsidian`, then set the
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
The vaults option here just writes vault path text files under xdg.dataFile — it doesn't auto-open or auto-import them into Obsidian's own vault list. You'd still add the vault path once inside Obsidian's UI the first time.
