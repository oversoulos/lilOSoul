# atomic/sys — Manual

## What this category is
Every module in `atomic/sys` is a system-level piece -- boot screens, login
managers, GPU diagnostics, theming, VPN, clipboard -- things that support
the desktop environment rather than being apps you open directly.

## What's in here
12 modules: greeter, display-manager, vulkan-tools, nextcloud, slurp, gtk,
plymouth, glxinfo, amdgpu-top, tailscale, wl-clipboard, wtype.

## How each module is structured
Every module folder has the same three working files (`config.nix` defines
the options, `module.nix` turns it on and sets values, `default.nix` glues
the two together) plus docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`,
and `_notes.md`/`_secrets` where relevant).

## Debugging at the category level
If nothing in `atomic/sys` takes effect after a rebuild, check that
`atomic/sys` itself is imported by `atomic/default.nix` -- one missing link
anywhere in that chain means none of it applies, even if every individual
module file is correct.

## Important: pick one login manager
`greeter` (greetd) and `display-manager` (SDDM) both manage login/session
start. Only enable one -- running both at once is a real conflict, not just
overlap. See each module's `_notes.md`.
