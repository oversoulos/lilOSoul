{ config, lib, ... }:

# Active configuration for eza.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.eza.enable = true;
}
