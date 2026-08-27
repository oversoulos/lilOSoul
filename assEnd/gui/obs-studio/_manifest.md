# obs-studio — Manifest

**Category:** atomic / gui
**Option namespace:** `programs.obs-studio`

## How to add to it
Add new settings inside `config.nix` under `options.programs.obs-studio`, then set the
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
enableVirtualCamera pulls in a kernel module and polkit — leave it off unless you actually need OBS to appear as a webcam elsewhere. It adds boot-level changes, not just a package install.
