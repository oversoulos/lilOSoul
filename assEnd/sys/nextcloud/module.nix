{ config, lib, ... }:

# Active configuration for nextcloud.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.nextcloud-client.enable = true;
}
