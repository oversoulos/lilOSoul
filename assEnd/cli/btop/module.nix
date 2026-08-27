{ config, lib, ... }:

# Active configuration for btop.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.btop.enable = true;
}
