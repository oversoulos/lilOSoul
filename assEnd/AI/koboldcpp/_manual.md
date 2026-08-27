# koboldcpp — Manual

## What this is
KoboldCPP — a local LLM inference engine with a built-in web GUI, running GGUF-format models. Vulkan backend enabled by default (useVulkan = true).

## Why it's here
Your primary local LLM runner — you already know this one well from your earlier CachyOS AI stack build, and Vulkan is the right backend for your Vega 7 iGPU since ROCm support is limited on this hardware.

## Dependencies
- A GGUF model file downloaded separately — this module installs the engine, not any model weights.
- Vulkan drivers/loader present at the system level (see atomic/sys/vulkan-tools for diagnostics).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.koboldcpp` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
