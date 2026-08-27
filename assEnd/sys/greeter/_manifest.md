# greeter — Manifest

**Category:** atomic / sys
**Option namespace:** `services.greetd`

## How to add to it
Add new settings inside `config.nix` under `options.services.greetd`, then set
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
This and display-manager.nix (SDDM) are both login/display managers. Only one should actually be enabled at a time — running both would conflict over who owns the login screen. Not resolved here since it's your call which one you want active.
