# podman — Manual

## What this is
Podman — a daemonless container engine (Docker-compatible CLI and API), configured here for rootless use by default, with podman-compose, buildah, and skopeo included.

## Why it's here
Container/dev-shell workflows — matches your plan to expand into local AI, graphic engineering, and media editing using dev shells and containers once your RAM upgrade lands.

## Dependencies
- virtualisation.podman (NixOS's real built-in Podman support) is enabled by this module's config — dockerCompat/dockerSocket options here make Podman usable via Docker-compatible tooling that expects `docker` commands/socket.

## How it's wired up
- `config.nix` — declares the full option surface (what *can* be configured).
- `module.nix` — turns it on and sets what ovrOS actually uses right now.
- `default.nix` — imports both; this is the file everything else points at.

## Debugging
- Nothing happening after rebuild? Check `module.nix` sets `enable = true` and that
  `services.podman` matches exactly what `config.nix` declares.
- Confirm this module is in `atomic/srvc/default.nix`'s imports list, and that
  `atomic/srvc` itself is imported further up the chain.
- Run `nixos-rebuild switch` and read the first error at the top of the output.
