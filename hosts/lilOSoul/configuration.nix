{ config, pkgs, lib, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/desktop
  ];

  networking.hostName = hostname;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    initialPassword = "4713";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "podman"
      "corectrl"
      "input"
    ];
    shell = pkgs.zsh;
  };

  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # Firewall rules for KDE Connect
  networking.firewall = {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
  };

  # zsh is set as the user's shell above, so it must be enabled system-wide too
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Do NOT bump this casually
  # after initial install — see the NixOS manual.
  system.stateVersion = "26.05";
}