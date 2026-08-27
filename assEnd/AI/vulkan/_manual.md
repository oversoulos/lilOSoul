# vulkan — Manual

## What this is
A system-wide switch for GPU-accelerated (Vulkan) AI inference — sets the `GGML_VULKAN` environment variable that llama.cpp-family engines (koboldcpp, whisper.cpp) read to enable GPU acceleration instead of falling back to CPU-only inference.

## Why it's here
The actual mechanism behind "use my Vega 7 iGPU instead of CPU for AI inference" across your whole AI stack — this is the general-purpose lever, separate from each individual tool's own useVulkan option.

## Dependencies
- Vulkan drivers/loader at the system level (atomic/sys/vulkan-tools has the diagnostic CLI to confirm this is actually working).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.ai-vulkan` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
