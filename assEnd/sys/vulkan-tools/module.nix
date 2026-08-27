{ config, lib, ... }:

# Active configuration for vulkan-tools.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.vulkan-tools.enable = true;
}
