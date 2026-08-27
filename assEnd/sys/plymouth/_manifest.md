# plymouth — Manifest

**Category:** atomic / sys
**Option namespace:** `services.plymouth`

## How to add to it
Add new settings inside `config.nix` under `options.services.plymouth`, then set
the value you want in `module.nix`. Don't set real values in `config.nix` — that
file is the definition, `module.nix` is the decision.

## Structure rule
Every atomic/sys module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs sit alongside the code, not inside it.

## Where it's imported
`atomic/sys/default.nix` imports this module's folder directly. `atomic/sys`
itself gets imported by `atomic/default.nix`.

## Known issues / conflicts
Enabling this flips boot.initrd.systemd.enable to true, which is a genuine boot-process change (switches to a systemd-based initrd), not just a visual splash toggle. Worth knowing before enabling if you're not expecting initrd changes.
