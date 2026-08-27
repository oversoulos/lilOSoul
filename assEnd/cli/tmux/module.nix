{ config, lib, ... }:

# Active configuration for tmux.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.tmux.enable = true;
}
