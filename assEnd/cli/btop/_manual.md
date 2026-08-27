# btop — Manual

## What this is
btop — a resource monitor (CPU, memory, disks, network, GPU where supported) with a polished terminal UI.

## Why it's here
Terminal-based system monitoring with more visual detail than htop — graphs, per-core CPU, and GPU info.

## Dependencies
- None beyond the package. GPU stats may need amdgpu-top or vulkan-tools (atomic/sys) for full Vega 7 iGPU detail depending on btop's build.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.btop` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
