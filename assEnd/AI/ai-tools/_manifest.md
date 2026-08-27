# ai-tools — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.ai-tools`

## How to add to it
Add new settings inside `config.nix` under `options.programs.ai-tools`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
This module was imported by molecular/AI/default.nix in the original dump but the file itself never actually showed up anywhere in the file contents — a phantom import pointing at nothing. This is a reconstructed, sensible-default version (general download/parsing tools relevant to an AI stack), not a recovery of lost content. Treat the tool list here as a starting point to edit, not something that reflects a decision you already made.
