{ config, lib, ... }:

# Active configuration for fuzzel.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.fuzzel.enable = true;
}
