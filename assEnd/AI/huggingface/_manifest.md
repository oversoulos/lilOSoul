# huggingface — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.huggingface`

## How to add to it
Add new settings inside `config.nix` under `options.programs.huggingface`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
None currently noted.
