# dnscrypt-proxy — Manifest

**Category:** atomic / netSec
**Option namespace:** `services.dnscrypt-proxy`

## How to add to it
Add new settings inside `config.nix` under `options.services.dnscrypt-proxy`, then set
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
The original file referenced a `configFile` variable in the systemd service's ExecStart line that was never actually defined anywhere in the file — it would have failed to evaluate at all. Fixed by generating configFile from the settings option using settingsFormat.generate.
