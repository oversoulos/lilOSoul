# huggingface — Manual

## What this is
The Hugging Face Hub CLI — command-line tool for downloading models/datasets from huggingface.co directly, without a browser.

## Why it's here
Faster/scriptable way to pull GGUF models or whisper models than manually downloading through a browser — useful groundwork for automating model management via your own scripts.

## Dependencies
- A Hugging Face account (free) if you need to download gated/private models — public model downloads work without login.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.huggingface` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
