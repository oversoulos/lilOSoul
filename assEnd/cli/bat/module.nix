{ config, lib, ... }:

# Active configuration for bat.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.bat.enable = true;
}
