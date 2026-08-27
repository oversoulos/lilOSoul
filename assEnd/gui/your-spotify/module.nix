{ config, lib, ... }:

# Active configuration for your-spotify.
# This is the "turn it on" file -- config.nix declares what's possible,
# this file decides what ovrOS actually uses right now.
{
  services.your-spotify.enable = true;
}
