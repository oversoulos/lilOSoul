# vulkan — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.ai-vulkan`

# vulkan — Notes (AI-assistant observations, not acted on)

The original file set GGML_VULKAN unconditionally (no way to turn it off) and separately declared a completely disconnected option, `mogis.artfHst.enable` ("master toggle for AI + hosting modules") that nothing else in the entire dump references. Rebuilt as a proper module with its own real enable option; the orphaned master-toggle idea wasn't carried forward as a working option since nothing hooks into it, but it's worth mentioning: that concept — one master switch for your whole AI + hosting stack — lines up with the `hstAI` abbreviation already in your own naming plans. Could be worth building as a real cross-category toggle later, this just isn't the place it was actually wired up.

## What this is
A system-wide switch for GPU-accelerated (Vulkan) AI inference — sets the `GGML_VULKAN` environment variable that llama.cpp-family engines (koboldcpp, whisper.cpp) read to enable GPU acceleration instead of falling back to CPU-only inference.

## Why it's here
The actual mechanism behind "use my Vega 7 iGPU instead of CPU for AI inference" across your whole AI stack — this is the general-purpose lever, separate from each individual tool's own useVulkan option.

## Dependencies
- Vulkan drivers/loader at the system level (atomic/sys/vulkan-tools has the diagnostic CLI to confirm this is actually working).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).


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


no cheatshet
# vulkan — Cheatsheet

- Nothing to run directly — this just sets an environment variable other AI tools read automatically once enabled
- `echo $GGML_VULKAN` — confirm it's actually set to 1 in your shell
