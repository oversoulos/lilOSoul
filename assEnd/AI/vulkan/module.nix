{ config, lib, ... }:

# Active configuration for vulkan.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.ai-vulkan.enable = true;
}
