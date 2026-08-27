{ config, lib, ... }:

# Active configuration for dnscrypt-proxy.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.dnscrypt-proxy.enable = true;
}
