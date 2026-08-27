{ config, lib, ... }:

# Active configuration for htop.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.htop.enable = true;
}
