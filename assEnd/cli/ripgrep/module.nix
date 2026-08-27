{ config, lib, ... }:

# Active configuration for ripgrep.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.ripgrep.enable = true;
}
