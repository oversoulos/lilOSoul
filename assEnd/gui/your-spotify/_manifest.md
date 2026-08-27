# your-spotify — Manifest

**Category:** atomic / gui
**Option namespace:** `services.your-spotify`

## How to add to it
Add new settings inside `config.nix` under `options.services.your-spotify`, then set the
value you want in `module.nix`. Don't set values directly in `config.nix` — that file is
the definition, `module.nix` is the decision.

## Structure rule
Every atomic/gui module follows the same three-file split:
`config.nix` (definition) + `module.nix` (decision) + `default.nix` (glue).
Docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`) sit alongside, not inside, the code.

## Where it's imported
`atomic/gui/default.nix` imports this module's folder directly. `atomic/gui` itself gets
imported by `atomic/default.nix`.

## Known issues / conflicts
This is a background service (systemd unit), not something you launch like a normal app — it needs spotifyPublic (client ID) and spotifySecretFile (a file holding the client secret) filled in before it will actually start successfully. See _secrets below.
