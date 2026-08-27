{ config, lib, ... }:

# Active configuration for fzf.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.fzf.enable = true;
}
