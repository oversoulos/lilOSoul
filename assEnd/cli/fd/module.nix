{ config, lib, ... }:

# Active configuration for fd.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.fd.enable = true;
}
