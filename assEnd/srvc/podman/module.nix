{ config, lib, ... }:

# Active configuration for podman.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.podman.enable = true;
}
