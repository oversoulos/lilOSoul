{ config, lib, ... }:

# Active configuration for vlc.
# This is the "turn it on" file -- config.nix declares what's possible,
# this file decides what ovrOS actually uses right now.
{
  programs.vlc.enable = true;
}
