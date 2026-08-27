# nerd-dictation — Manual

## What this is
Nerd Dictation — the voice-to-text trigger layer: listens for a keybind, records audio, feeds it to a speech-to-text engine (whisper.cpp here), and types the transcribed text into whatever window has focus.

## Why it's here
This is your SUPER+Space (or configured keybind) 'push a button and talk' dictation setup — the actual feature you're chasing, matching that phone-dictation-quality experience you described.

## Dependencies
- whisper.cpp (the actual transcription engine — declared as a dependency by this module).
- wtype (declared as a dependency here) for typing the transcribed text into the focused window — atomic/srvc/ydotool is a second, separate way to do the same job; only one of the two typing-injection tools should actually be relied on so you're not troubleshooting the wrong one when something doesn't type.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.nerd-dictation` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
