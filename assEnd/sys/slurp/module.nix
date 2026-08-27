{ config, lib, ... }:

# Active configuration for slurp.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.slurp.enable = true;
}
