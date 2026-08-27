# cloudflared — Manifest

**Category:** atomic / netSec
**Option namespace:** `services.cloudflared`

## How to add to it
Add new settings inside `config.nix` under `options.services.cloudflared`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` --
that file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/netSec module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/netSec/default.nix` imports this module's folder directly.
`atomic/netSec` itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
atomic/netSec/default.nix pointed at this file as `cloudfared.nix` (missing the second 'l') — a typo that would have broken the import entirely. Fixed as part of this pass.
