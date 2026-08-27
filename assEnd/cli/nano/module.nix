{ config, lib, ... }:

# Active configuration for nano.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.nano.enable = true;
}
