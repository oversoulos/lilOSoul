{ config, lib, ... }:

# Active configuration for glxinfo.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.glxinfo.enable = true;
}
