{ config, lib, ... }:

# Active configuration for cloudflared.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.cloudflared.enable = true;
}
