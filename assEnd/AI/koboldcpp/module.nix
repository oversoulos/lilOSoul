{ config, lib, ... }:

# Active configuration for koboldcpp.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.koboldcpp.enable = true;
}
