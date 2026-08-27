{ config, lib, ... }:

# Active configuration for gh.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.gh.enable = true;
}
