{ config, lib, ... }:

# Active configuration for fastfetch.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.fastfetch.enable = true;
}
