# atomic/cli — Manual

## What this category is
Every module in `atomic/cli` is a terminal/command-line tool -- things you
type and run, as opposed to `atomic/gui` (windowed apps) or `atomic/sys`
(system-level services).

## What's in here
19 modules: gh, starship, nano, lazygit, fd, htop, yazi, tmux, eza, btop,
bat, zsh, neovim, fuzzel, ripgrep, fastfetch, fzf, git, ghostty.

## How each module is structured
Every module folder has the same three working files (`config.nix` defines
the options, `module.nix` turns it on and sets values, `default.nix` glues
the two together) plus docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`,
and `_notes.md` where something is worth flagging).

## Debugging at the category level
If nothing in `atomic/cli` shows up after a rebuild, check that `atomic/cli`
itself is imported by `atomic/default.nix` -- one missing link anywhere in
that chain (module → cli → atomic → your top-level config) means none of it
takes effect, even if every individual module file is correct.
