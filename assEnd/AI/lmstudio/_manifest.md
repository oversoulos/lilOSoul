# lmstudio — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.lmstudio`

## How to add to it
Add new settings inside `config.nix` under `options.programs.lmstudio`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
This module doesn't expose a backend-selection option (Vulkan vs CPU vs ROCm) — that choice happens inside LM Studio's own UI after install, not through NixOS config. Given your ROCm-support concerns, that's specifically where you'd want to confirm it's set to Vulkan.
