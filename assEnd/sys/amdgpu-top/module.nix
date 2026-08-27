{ config, lib, ... }:

# Active configuration for amdgpu-top.
# config.nix declares what's possible, this file decides what ovrOS uses now.
{
  programs.amdgpu-top.enable = true;
}
