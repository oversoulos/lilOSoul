{ config, lib, ... }:

# Active configuration for wtype.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.wtype.enable = true;
}
