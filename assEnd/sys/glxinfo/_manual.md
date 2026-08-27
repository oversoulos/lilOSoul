# glxinfo — Manual

## What this is
glxinfo — a diagnostic tool that reports OpenGL driver/renderer details (the older graphics API, alongside Vulkan).

## Why it's here
Useful alongside vulkan-tools for confirming your Vega 7 iGPU's OpenGL support, for anything (older games, some apps) that still relies on OpenGL instead of Vulkan.

## Dependencies
- A working OpenGL/Mesa driver already installed at the system level.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.glxinfo` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
