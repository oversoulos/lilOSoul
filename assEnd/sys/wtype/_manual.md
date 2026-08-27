# wtype — Manual

## What this is
wtype — a command-line tool that simulates keyboard input (types text programmatically) under Wayland, the Wayland equivalent of X11's `xdotool type`.

## Why it's here
Useful for scripting automated text entry — for example, your nerd-dictation voice-input setup likely needs something like this to actually type recognized speech into the focused window.

## Dependencies
- A Wayland compositor (Hyprland) — this tool is Wayland-specific.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.wtype` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
