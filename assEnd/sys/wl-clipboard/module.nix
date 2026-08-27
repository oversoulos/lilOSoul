{ config, lib, ... }:

# Active configuration for wl-clipboard.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.wl-clipboard.enable = true;
}
