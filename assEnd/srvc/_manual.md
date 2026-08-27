# atomic/srvc — Manual

## What this category is
Every module in `atomic/srvc` is a background service or daemon -- things
that run continuously (sync, device integration, automation, containers,
a self-hosted app) rather than apps you open directly.

## What's in here
5 modules: syncthing, kdeconnect, ydotool, bookstack, podman.

## How each module is structured
Every module folder has the same three working files (`config.nix` defines
the options, `module.nix` turns it on and sets values, `default.nix` glues
the two together) plus docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`,
and `_secrets`/`_notes.md` where relevant).

## Debugging at the category level
If nothing in `atomic/srvc` takes effect after a rebuild, check that
`atomic/srvc` itself is imported by `atomic/default.nix` -- one missing
link anywhere in that chain means none of it applies.
