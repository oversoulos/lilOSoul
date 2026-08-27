# lmstudio — Manual

## What this is
LM Studio — a polished GUI for downloading, managing, and running local LLMs, with its own built-in model browser/downloader.

## Why it's here
You mentioned trying this specifically because you're redoing Vulkan settings and tools since ROCm support is lacking on your hardware — LM Studio has more visual model management than koboldcpp, at the cost of being closed-source/unfree.

## Dependencies
- Marked unfree in nixpkgs — this module already flips nixpkgs.config.allowUnfree = true system-wide when enabled (same effect as the Spotify module in atomic/gui, if you also use that).

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.lmstudio` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
