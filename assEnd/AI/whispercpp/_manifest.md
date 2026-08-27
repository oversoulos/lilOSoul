# whispercpp — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.whispercpp`

## How to add to it
Add new settings inside `config.nix` under `options.programs.whispercpp`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
Model accuracy vs speed is the main lever for getting dictation quality close to what you described (something as accurate as a good phone dictation feature). `base` (the default) is fast but noticeably less accurate than `small` or `medium` — worth testing `small` first as a middle ground, especially since your Vega 7 iGPU handles Vulkan-accelerated inference reasonably well and you'll have 32GB RAM to work with.
