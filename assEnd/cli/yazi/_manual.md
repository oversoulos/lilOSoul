# yazi — Manual

## What this is
Yazi — a fast terminal file manager with image/video/PDF preview support.

## Why it's here
Your primary terminal-based file browser — navigate, preview, and manage files without a GUI file manager.

## Dependencies
- poppler (PDF previews), resvg (SVG previews), imagemagick (image previews), ffmpeg (video previews), jq (JSON previews), zoxide (fast directory jumping) — all pulled in automatically by this module's config.nix.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.yazi` matches exactly what `config.nix` declares — a mismatched
  name means the option silently does nothing instead of erroring.
- Confirm this module is in `atomic/cli/default.nix`'s imports list, and that
  `atomic/cli` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
