# security — Manifest

**Category:** atomic / netSec
**Option namespace:** `molecular.security`

## How to add to it
Add new settings inside `config.nix` under `options.molecular.security`, then set
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
This module's actual option path is `molecular.security`, not `atomic.security` or `netSec.security` — despite living in the atomic/netSec folder, its namespace suggests it may have originally been intended as (or copied from) a molecular-tier module. Left as-is since renaming the option would be a bigger structural change than this pass covers, but worth knowing when you go looking for its config later. It also duplicates atomic/sys/tailscale.nix's job for turning Tailscale on -- not a conflict, just two switches that do the same thing.
