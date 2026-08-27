{ config, lib, ... }:

# Active configuration for nntp-proxy.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.nntp-proxy.enable = true;
}
