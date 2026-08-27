{ config, lib, ... }:

# Active configuration for lmstudio.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.lmstudio.enable = true;
}
