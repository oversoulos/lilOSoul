{ config, lib, ... }:

# Active configuration for pdfarranger.
# This is the "turn it on" file -- config.nix declares what's possible,
# this file decides what ovrOS actually uses right now.
{
  programs.pdfarranger.enable = true;
}
