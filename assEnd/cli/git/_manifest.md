# git — Manifest

**Category:** atomic / cli
**Option namespace:** `programs.git`

## How to add to it
Add new settings inside `config.nix` under `options.programs.git`, then set
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
userName, userEmail, and signingKey all default to null (unset). Nothing in this file requires you to fill them in immediately — just know commits will use whatever git falls back to (or fail if git can't determine an identity at all) until they're set in module.nix.
