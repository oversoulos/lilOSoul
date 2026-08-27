# spotify — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.spotify`

## How to add to it
Add new settings inside `config.nix` under `options.programs.spotify`, then set the
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
nixpkgs.config.allowUnfree = true here is a system-wide setting, not scoped to just Spotify — turning this module on also permits other unfree packages elsewhere in the config to install without extra flags. Worth knowing, not necessarily a problem.
