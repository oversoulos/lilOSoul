# shadowsocks — Manual

## What this is
Shadowsocks — a lightweight SOCKS5 proxy designed to look like ordinary encrypted traffic, commonly used to route traffic through a remote server to bypass network restrictions or add a layer of privacy.

## Why it's here
A simple encrypted proxy option — lighter-weight than a full VPN, point apps that support SOCKS5 proxies at it.

## Dependencies
- A server to actually run this on (or a remote shadowsocks server to connect to, depending on which side you're deploying) — this module configures the server side.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.shadowsocks` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/netSec/default.nix`'s imports list, and that
  `atomic/netSec` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
