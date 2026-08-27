# vulkan-tools — Manual

## What this is
Vulkan diagnostic tools — vulkaninfo (reports Vulkan driver/device details) and vkcube (a spinning-cube test to confirm Vulkan rendering actually works).

## Why it's here
Useful for confirming your Vega 7 iGPU's Vulkan support is working correctly, especially relevant since your AI stack (koboldcpp) uses Vulkan inference.

## Dependencies
- A working Vulkan driver already installed at the system level (this module just adds the diagnostic CLI tools, not the driver itself).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.vulkan-tools` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
