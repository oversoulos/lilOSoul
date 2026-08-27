# vulkan — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.ai-vulkan`

## How to add to it
Add new settings inside `config.nix` under `options.programs.ai-vulkan`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
The original file set GGML_VULKAN unconditionally (no way to turn it off) and separately declared a completely disconnected option, `mogis.artfHst.enable` ("master toggle for AI + hosting modules") that nothing else in the entire dump references. Rebuilt as a proper module with its own real enable option; the orphaned master-toggle idea wasn't carried forward as a working option since nothing hooks into it, but it's worth mentioning: that concept — one master switch for your whole AI + hosting stack — lines up with the `hstAI` abbreviation already in your own naming plans. Could be worth building as a real cross-category toggle later, this just isn't the place it was actually wired up.
