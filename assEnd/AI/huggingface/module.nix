{ config, lib, ... }:

# Active configuration for huggingface.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.huggingface.enable = true;
}
