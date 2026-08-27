# atomic/gui — Manual

## What this category is
Every module in `atomic/gui` is a standalone graphical (windowed) application --
things you click and see on screen, as opposed to `atomic/cli` (terminal tools)
or `atomic/sys` (system-level services with no direct UI).

## What's in here
22 modules: imv, mission-center, obs-studio, swww, okular, mako, foot, insomnia,
ewww, spotify, thunar, dbeaver, waybar, onlyoffice, vlc, your-spotify, mousepad,
rofi, obsidian, pdfarranger, vscode, vesktop.

`bitwarden/` also exists as a folder but is currently empty and not imported --
skipped for now per your call.

## How each module is structured
Every module folder has the same three working files (`config.nix` defines the
options, `module.nix` turns it on and sets values, `default.nix` glues the two
together) plus docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`, and
`_secrets`/`_notes.md` where relevant).

## Debugging at the category level
If nothing in `atomic/gui` is showing up after a rebuild, check that
`atomic/gui` itself is imported by `atomic/default.nix` -- a single missing
link anywhere in that chain (module → gui → atomic → your top-level config)
means none of it takes effect, even if every individual module file is correct.
