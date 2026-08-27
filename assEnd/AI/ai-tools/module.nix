{ config, lib, ... }:

# Active configuration for ai-tools.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.ai-tools.enable = true;
}
