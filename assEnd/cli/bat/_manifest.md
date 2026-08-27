# bat — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.bat`

## How to add to it
Add new settings inside `config.nix` under `options.programs.bat`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` — that
file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/cli module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/cli/default.nix` imports this module's folder directly. `atomic/cli`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
config.nix currently has environment.etc."bat/config".text defined twice — the second definition silently wins in Nix (last one set), so the first `settings`-driven block never actually takes effect. Flagging it here since it's a real bug carried over from the original file, not something introduced by this rewrite.
