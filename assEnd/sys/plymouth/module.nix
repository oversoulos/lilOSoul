{ config, lib, ... }:

# Active configuration for plymouth.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.plymouth.enable = true;
}
