{ config, lib, ... }:

# Active configuration for tailscale.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.tailscale.enable = true;
}
