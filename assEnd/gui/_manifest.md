# atomic/gui — Manifest

**Category:** atomic (individual, standalone components)
**Type:** gui (windowed desktop applications)

## How to add a new module here
1. Make a new folder under `atomic/gui/<name>/`.
2. Give it `config.nix` (options + config, following the pattern already used
   by every other module in this folder), `module.nix` (the enable/settings
   file), and `default.nix` (imports both).
3. Add `../gui/<name>` to the `imports` list in `atomic/gui/default.nix`.
4. Add the matching docs: `_manual.md`, `_manifest.md`, `_cheatsheets.md`.

## Structure rules
- One module = one folder. No shared/multi-app files.
- `config.nix` never sets real values, only declares what's possible.
- `module.nix` is the only place `enable = true` (or real settings) should live.
- Docs live beside the code, not inside it.

## Current integrations
All 22 modules are imported by `atomic/gui/default.nix`, which is in turn
imported by `atomic/default.nix`.

## Known issues
- `bitwarden/` is an empty folder, intentionally left out of the import list.
- `insomnia/`'s original file content was actually a Bitwarden config (a
  copy/paste mismatch in the source dump) -- it's been rebuilt to match its
  folder name and now configures the real Insomnia API client instead.
