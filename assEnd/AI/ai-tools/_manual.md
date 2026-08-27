# ai-tools — Manual

## What this is
A general-purpose grab-bag of AI-adjacent CLI utilities: curl and aria2 (downloading model files, including large ones with aria2's multi-connection speed), jq (parsing JSON API responses from local LLM servers), and git-lfs (pulling large files from HuggingFace/GitHub repos that use Git LFS for model weights).

## Why it's here
Small, general-purpose tools that support the rest of your AI stack — mostly for scripting model downloads and API interactions, which lines up with the scripting work you mentioned already being underway.

## Dependencies
- None beyond the packages themselves.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.ai-tools` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
