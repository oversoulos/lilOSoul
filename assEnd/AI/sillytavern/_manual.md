# sillytavern — Manual

## What this is
SillyTavern — a web-based chat frontend for talking to local (or remote) LLMs, with character cards, personas, and chat management — much richer than a raw API playground.

## Why it's here
A frontend layer on top of an LLM backend like koboldcpp — matches your earlier three-persona system design (Lucy/Dozer/Bot) if you want a GUI for managing those personas instead of building your own retro AIM-style interface from scratch.

## Dependencies
- A running LLM backend with an API to point at (koboldcpp's API endpoint, once that's running) — SillyTavern itself doesn't run models, it's a chat client.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `programs.sillytavern` matches exactly what `config.nix` declares.
- Confirm this module is in `molecular/AI/default.nix`'s imports list, and that
  `molecular/AI` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
