# obs-studio — Manual

## What this is
OBS Studio — screen recording and live streaming software, with optional plugin support and a virtual webcam.

## Why it's here
Recording gameplay/demos or streaming; the virtual camera lets OBS output act as a webcam in other apps (e.g. video calls).

## Dependencies
- v4l2loopback kernel module (only needed if enableVirtualCamera is turned on)
- polkit (auto-enabled if virtual camera is on, needed for permission prompts)

## How it's wired up
- `config.nix` — declares the full option surface for this module (what *can* be configured).
- `module.nix` — turns it on and sets the settings ovrOS actually uses right now.
- `default.nix` — imports both of the above; this is the file everything else points at.

## Debugging
- Module not doing anything? Check `module.nix` actually sets `enable = true` and that
  `programs.obs-studio` matches what `config.nix` declares — a typo here means the option
  silently does nothing instead of erroring.
- Package missing after rebuild? Confirm this module is imported by `atomic/gui/default.nix`,
  and that `atomic/gui/default.nix` itself is imported further up the chain.
- Run `nixos-rebuild switch` (or your flake's equivalent) and read the error at the top of
  the output — Nix errors point at the exact file/line that's wrong.
