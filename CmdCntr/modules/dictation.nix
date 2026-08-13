{ pkgs, ... }:
{
  # koboldcpp / whisper.cpp / voice-anywhere dictation — INTENTIONALLY LEFT
  # AS A STUB, not a working config, for one honest reason: I can't
  # currently confirm these exist under those exact names in nixpkgs
  # without risking putting a package name in here that doesn't exist and
  # breaking your whole build on first try. Rather than guess and hand you
  # something that silently fails, here's the real state and the real
  # options, so you can pick with full info instead of me picking blind:
  #
  # 1. koboldcpp — you've already built this manually before (in ~/ai on a
  #    prior machine). If it's not a clean nixpkgs package, running it the
  #    same way you already know (manual/binary, or its own repo's install
  #    script) is the most reliable path — a `home.packages` entry isn't
  #    required for that; it can just live in your home directory like
  #    before, outside Nix entirely, and still work fine.
  #
  # 2. Voice-to-text "anywhere," like a keyboard:
  #    - whisper.cpp: transcription engine, heavier, more accurate.
  #    - nerd-dictation: lighter, purpose-built for exactly this — hotkey,
  #      talk, text appears wherever your cursor is focused.
  #    - Either one needs pairing with a Wayland text-injection tool
  #      (`wtype` or `ydotool`) to actually type the transcribed text into
  #      whatever window is focused — transcription alone doesn't do that
  #      part.
  #
  # When you're ready to lock this in, tell me which pairing you want
  # (nerd-dictation+wtype is the simplest/lightest) and I'll wire up a real
  # working module here instead of this note.

  home.packages = [ ];
}
