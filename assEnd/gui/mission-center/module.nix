{ config, lib, ... }:

# Active configuration for mission-center.
# This is the "turn it on" file -- config.nix declares what's possible,
# this file decides what ovrOS actually uses right now.
{
  programs.mission-center.enable = true;
}
