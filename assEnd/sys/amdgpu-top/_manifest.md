# amdgpu-top — Manifest

**Category:** atomic / sys
**Option namespace:** `programs.amdgpu-top`

## How to add to it
Add new settings inside `config.nix` under `options.programs.amdgpu-top`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` — that
file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/sys module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/sys/default.nix` imports this module's folder directly. `atomic/sys`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
Overlaps with mission-center (gui) and btop (cli) as system monitors — this one is specifically GPU-focused and AMD-specific, the most detailed option for iGPU stats specifically.
