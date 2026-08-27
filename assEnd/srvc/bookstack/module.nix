{ config, lib, ... }:

# Active configuration for bookstack.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  services.bookstack.enable = true;
}
