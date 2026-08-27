{ config, lib, ... }:

# Active configuration for kdeconnect.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.kdeconnect.enable = true;
}
