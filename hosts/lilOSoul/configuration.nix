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
    # Single-user machine, no login manager beyond this. Password is set in
    # plain text here (`initialPassword`) which NixOS hashes into place on
    # first build — simplest option for a single-user box. Known tradeoff:
    # this file is readable in the repo, including while public during
    # install (see README). Change any time with `passwd` once booted, or
    # switch this to `hashedPassword` later if wanted.
    initialPassword = "4713";
    extraGroups = [
      "wheel"          # sudo
      "networkmanager" # network control
      "video"          # GPU/display access
      "audio"          # sound devices
      "podman"         # rootless containers
      "corectrl"       # lets CoreCtrl adjust GPU without a password prompt each time
      "input"          # needed by dictation tools (nerd-dictation/ydotool) to inject keystrokes
    ];
    shell = pkgs.zsh;
  };

  # zsh is set as the user's shell above, so it must be enabled system-wide too
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Do NOT bump this casually
  # after initial install — see the NixOS manual.
  system.stateVersion = "26.05";
}
