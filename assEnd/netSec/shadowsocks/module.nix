{ config, lib, ... }:

# Active configuration for shadowsocks.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.shadowsocks.enable = true;
}
