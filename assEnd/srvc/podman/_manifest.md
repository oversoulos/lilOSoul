# podman — Manifest

**Category:** atomic / srvc
**Option namespace:** `services.podman`

## How to add to it
Add new settings inside `config.nix` under `options.services.podman`, then set
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
This module sets `User = if cfg.rootless then "1000" else "root"` for the podman system service — hardcoding UID 1000 assumes that's your user's UID. If your actual user account isn't UID 1000, this service would try to run as the wrong user. Worth checking `id -u` against this before relying on rootless mode working as expected.
