# whispercpp — Manual

## What this is
Whisper.cpp — a fast, local speech-to-text engine (OpenAI's Whisper model, reimplemented for efficient local/offline inference). Vulkan backend enabled by default.

## Why it's here
This is the actual speech-recognition engine behind voice dictation — nerd-dictation (below) is the trigger/glue layer, whisper.cpp is what's doing the listening-and-transcribing work.

## Dependencies
- A Whisper model file for the size you pick (tiny/base/small/medium/large) — larger models are more accurate but slower and use more RAM/VRAM.
- Vulkan drivers at the system level for GPU-accelerated transcription on your Vega 7 iGPU.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.whispercpp` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
