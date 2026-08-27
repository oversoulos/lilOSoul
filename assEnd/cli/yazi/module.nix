{ config, lib, ... }:

# Active configuration for yazi.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.yazi.enable = true;
}
