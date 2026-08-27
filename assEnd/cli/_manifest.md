# atomic/cli — Manifest

**Category:** atomic (individual, standalone components)
**Type:** cli (terminal / command-line tools)

## How to add a new module here
1. Make a new folder under `atomic/cli/<name>/`.
2. Give it `config.nix` (options + config, matching the pattern used by
   every other module here), `module.nix` (the enable/settings file), and
   `default.nix` (imports both).
3. Add `../cli/<name>` to the `imports` list in `atomic/cli/default.nix`.
4. Add the matching docs: `_manual.md`, `_manifest.md`, `_cheatsheets.md`.

## Structure rules
- One module = one folder. No shared/multi-tool files.
- `config.nix` never sets real values, only declares what's possible.
- `module.nix` is the only place `enable = true` (or real settings) should live.
- Docs live beside the code, not inside it.

## Current integrations
All 19 modules are imported by `atomic/cli/default.nix`, which is in turn
imported by `atomic/default.nix`. Several modules depend on `zsh` being
enabled for their shell-integration options to do anything (starship, fzf).

## Known issues
- `tmux/` previously held a nested `zoxide/default.nix` instead of any real
  tmux config (a naming mismatch in the source dump). Per your call, that's
  been rebuilt as genuine tmux, and zoxide was scrapped entirely -- not
  migrated anywhere else in this category.
- `bat/config.nix` sets `environment.etc."bat/config".text` twice in the
  original source; the second definition silently overrides the first in
  Nix. Carried over as-is, flagged in that module's `_notes.md`.
