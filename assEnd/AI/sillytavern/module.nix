{ config, lib, ... }:

# Active configuration for sillytavern.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.sillytavern.enable = true;
}
