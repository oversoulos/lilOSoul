{ config, lib, ... }:

# Active configuration for whispercpp.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.whispercpp.enable = true;
}
