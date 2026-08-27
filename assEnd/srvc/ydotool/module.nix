{ config, lib, ... }:

# Active configuration for ydotool.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.ydotool.enable = true;
}
