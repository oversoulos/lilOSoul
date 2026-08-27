{ config, lib, ... }:

# Active configuration for gtk.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.gtk.enable = true;
}
