# atomic/srvc — Manifest

**Category:** atomic (individual, standalone components)
**Type:** srvc (background services / daemons)

## How to add a new module here
1. Make a new folder under `atomic/srvc/<name>/`.
2. Give it `config.nix` (options + config), `module.nix` (the enable/settings
   file), and `default.nix` (imports both) -- same pattern as every other
   module here.
3. Add `../srvc/<name>` to the `imports` list in `atomic/srvc/default.nix`.
4. Add the matching docs: `_manual.md`, `_manifest.md`, `_cheatsheets.md`.

## Structure rules
- One module = one folder. No shared/multi-tool files.
- `config.nix` never sets real values, only declares what's possible.
- `module.nix` is the only place `enable = true` (or real settings) should live.
- Docs live beside the code, not inside it.

## Current integrations
All 5 modules are imported by `atomic/srvc/default.nix`, which is in turn
imported by `atomic/default.nix`.

## Known issues
- `bookstack` has no database module of its own -- it needs a MySQL/MariaDB
  or Postgres service configured separately before it will actually run.
- `podman`'s systemd service hardcodes `User = "1000"` for rootless mode --
  only correct if your actual user account is UID 1000.
- `ydotool` is the most likely dependency behind your nerd-dictation setup
  actually typing recognized speech -- worth confirming that integration
  points at this daemon's socket.
