# amdgpu-top — Manual

## What this is
amdgpu-top — a real-time terminal monitoring tool specifically for AMD GPUs (usage, clocks, VRAM, power draw).

## Why it's here
GPU-specific monitoring for your Vega 7 iGPU that general tools like htop/btop don't show in the same depth.

## Dependencies
- An AMD GPU with the amdgpu kernel driver active (which your Vega 7 iGPU uses by default on Linux).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.amdgpu-top` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
