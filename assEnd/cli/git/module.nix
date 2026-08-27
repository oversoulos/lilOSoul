{ config, lib, ... }:

# Active configuration for git.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.git.enable = true;
}
