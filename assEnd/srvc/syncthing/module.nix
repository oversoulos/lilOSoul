{ config, lib, ... }:

# Active configuration for syncthing.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.syncthing.enable = true;
}
