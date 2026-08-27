{ config, lib, ... }:

# Active configuration for lazygit.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.lazygit.enable = true;
}
