# ghostunnel — Manifest

**Category:** atomic / netSec
**Option namespace:** `services.unknown`

## How to add to it
Add new settings inside `config.nix` under `options.services.unknown`, then set
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
This is the fuller of two ghostunnel implementations found in the dump — a simpler single-tunnel version (ghost-tunnel.nix) was scrapped per your call in favor of this multi-server one, since it exposes more of what's actually configurable. Every server you define needs at least one access-control option set (allowAll, allowCN, etc.) or NixOS will refuse to build — module.nix's example includes allowAll = true as a placeholder specifically so it evaluates out of the box; swap that for a real access-control rule before actually exposing anything.
