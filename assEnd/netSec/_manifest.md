# atomic/netSec — Manifest

**Category:** atomic (individual, standalone components)
**Type:** netSec (networking and security services)

## How to add a new module here
1. Make a new folder under `atomic/netSec/<name>/`.
2. Give it `config.nix` (options + config), `module.nix` (the enable/settings
   file), and `default.nix` (imports both) -- same pattern as every other
   module here.
3. Add `../netSec/<name>` to the `imports` list in `atomic/netSec/default.nix`.
4. Add the matching docs: `_manual.md`, `_manifest.md`, `_cheatsheets.md`.

## Structure rules
- One module = one folder. No shared/multi-tool files.
- `config.nix` never sets real values, only declares what's possible.
- `module.nix` is the only place `enable = true` (or real settings) should live.
- Docs live beside the code, not inside it.
- Don't re-declare options NixOS already ships built-in (firewall,
  NetworkManager) -- configure those directly, don't duplicate the module.

## Current integrations
All 6 modules are imported by `atomic/netSec/default.nix`, which is in turn
imported by `atomic/default.nix`.

## Known issues
- `default.nix` had two import-path typos (`cloudfared.nix`,
  `dnscrypt-proxy.net`) that would have broken the build -- fixed.
- `dnscrypt-proxy.nix` referenced an undefined `configFile` variable --
  fixed by generating it from the `settings` option.
- `security.nix`'s real option path is `molecular.security`, despite living
  in `atomic/netSec` -- likely copied in from elsewhere. Left as-is;
  documented in that module's own `_notes.md`.
- `security` also duplicates `atomic/sys/tailscale.nix`'s job of turning
  Tailscale on -- not a conflict, just two switches for the same thing.
