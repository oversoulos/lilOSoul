{ config, lib, ... }:

# Active configuration for neovim.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.neovim.enable = true;
}
