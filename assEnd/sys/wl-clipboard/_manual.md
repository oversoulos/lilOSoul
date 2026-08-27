# wl-clipboard — Manual

## What this is
wl-clipboard — command-line clipboard tools (wl-copy / wl-paste) for Wayland, since the X11 xclip/xsel tools don't work under Wayland compositors like Hyprland.

## Why it's here
Lets scripts and terminal commands read/write the system clipboard — needed for things like piping command output to the clipboard, or scripted paste actions.

## Dependencies
- A Wayland compositor (Hyprland) — these tools are Wayland-specific and won't work under X11.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.wl-clipboard` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/sys/default.nix`'s imports list, and that
  `atomic/sys` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
