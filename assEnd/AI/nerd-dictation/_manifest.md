# nerd-dictation — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.nerd-dictation`

## How to add to it
Add new settings inside `config.nix` under `options.programs.nerd-dictation`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
The default keybind here is Alt+Shift+V, but your own notes describe SUPER+Space as the intended dictation trigger — worth double-checking module.nix's `keybind` value matches what you actually want, and that whatever's bound in Hyprland calls this correctly. Also: this module lists wtype as its typing-injection dependency, while atomic/srvc/ydotool.nix does the same job independently — pick one as the real path (see that module's notes) so dictation doesn't silently fail because the wrong tool is what's actually wired up in Hyprland.
