# atomic/sys — Manifest

**Category:** atomic (individual, standalone components)
**Type:** sys (system-level services and diagnostics)

## How to add a new module here
1. Make a new folder under `atomic/sys/<name>/`.
2. Give it `config.nix` (options + config, matching the pattern used by
   every other module here), `module.nix` (the enable/settings file), and
   `default.nix` (imports both).
3. Add `../sys/<name>` to the `imports` list in `atomic/sys/default.nix`.
4. Add the matching docs: `_manual.md`, `_manifest.md`, `_cheatsheets.md`.

## Structure rules
- One module = one folder. No shared/multi-tool files.
- `config.nix` never sets real values, only declares what's possible.
- `module.nix` is the only place `enable = true` (or real settings) should live.
- Docs live beside the code, not inside it.

## Current integrations
All 12 modules are imported by `atomic/sys/default.nix`, which is in turn
imported by `atomic/default.nix`.

## Known issues / conflicts
- `greeter` (greetd) and `display-manager` (SDDM) both handle login/session
  start -- only one should be enabled at a time.
- `wtype` existed in the source dump but was never added to
  `atomic/sys/default.nix`'s imports list -- fixed as part of this pass.
- `slurp` selects a screen region but has no capture tool (e.g. grim) paired
  with it anywhere in this dump -- screenshots won't fully work until one's
  added as its own module.
