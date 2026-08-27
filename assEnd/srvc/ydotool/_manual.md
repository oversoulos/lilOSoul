# ydotool — Manual

## What this is
ydotool — a background daemon that lets scripts and tools simulate keyboard/mouse input at the OS level, working under Wayland (unlike xdotool, which is X11-only).

## Why it's here
This is very likely what your nerd-dictation voice-input setup (SUPER+Space) actually uses under the hood to type recognized speech into whatever window has focus.

## Dependencies
- /dev/uinput device access (handled via the systemd service's DeviceAllow setting) — the daemon needs this to simulate input events at all.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.ydotool` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/srvc/default.nix`'s imports list, and that
  `atomic/srvc` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
