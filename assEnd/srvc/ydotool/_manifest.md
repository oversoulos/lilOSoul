# ydotool — Manifest

**Category:** atomic / srvc
**Option namespace:** `services.ydotool`

## How to add to it
Add new settings inside `config.nix` under `options.services.ydotool`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/srvc module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/srvc/default.nix` imports this module's folder directly. `atomic/srvc`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
This is the most likely piece nerd-dictation depends on for actually injecting recognized speech as keystrokes — worth double-checking your nerd-dictation setup points at this daemon's socket (YDOTOOL_SOCKET, set automatically by this module) rather than expecting wtype or something else.
