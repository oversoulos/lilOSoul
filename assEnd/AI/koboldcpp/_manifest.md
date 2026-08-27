# koboldcpp — Manifest

**Category:** molecular / AI
**Option namespace:** `programs.koboldcpp`

## How to add to it
Add new settings inside `config.nix` under `options.programs.koboldcpp`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every molecular/AI module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`molecular/AI/default.nix` imports this module's folder directly.

## Known issues / conflicts
This module only installs the koboldcpp binary — it doesn't run it as a background service. Right now you'd launch it manually each time. If you want it always running (e.g. so other tools/scripts can hit its API without you starting it first), that needs a systemd user service added on top of this — a good candidate for the scripting work you mentioned you're already doing.
