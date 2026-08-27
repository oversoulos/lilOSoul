{ config, lib, ... }:

# Active configuration for ghostty.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.ghostty.enable = true;
}
