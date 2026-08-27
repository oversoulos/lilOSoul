# atomic/netSec — Manual

## What this category is
Every module in `atomic/netSec` handles networking or security at the
system level -- proxies, tunnels, VPN, DNS encryption, and a bundled
security-tools toggle.

## What's in here
6 modules: cloudflared, dnscrypt-proxy, ghostunnel, nntp-proxy, security,
shadowsocks.

Two files from the original dump were deliberately left out:
- `firewall.nix` and `networkmanager.nix` -- both verbatim copies of
  NixOS's own built-in modules for those exact same option paths. NixOS
  already provides both; a second copy of either would conflict with the
  real one. Turn them on the normal way (`networking.firewall.enable`,
  `networking.networkmanager.enable`) elsewhere in your system config, not
  as modules here.
- `ghost-tunnel.nix` -- a simpler, single-tunnel ghostunnel implementation,
  scrapped in favor of the fuller multi-server `ghostunnel.nix`.

## How each module is structured
Every module folder has the same three working files (`config.nix` defines
the options, `module.nix` turns it on and sets values, `default.nix` glues
the two together) plus docs (`_manual.md`, `_manifest.md`, `_cheatsheets.md`,
and `_secrets`/`_notes.md` where relevant).

## Debugging at the category level
If nothing in `atomic/netSec` takes effect after a rebuild, check that
`atomic/netSec` itself is imported by `atomic/default.nix` -- one missing
link anywhere in that chain means none of it applies.
