# bookstack — Manifest

**Category:** atomic / srvc
**Option namespace:** `services.bookstack`

## How to add to it
Add new settings inside `config.nix` under `options.services.bookstack`, then set
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
This module configures the web server and PHP side, but has no database module of its own — DB_HOST/DB_DATABASE/DB_USERNAME in the settings option point at a database that doesn't exist yet in this dump. Bookstack won't actually come up until a MySQL/MariaDB or Postgres service is added and configured to match.
