{ pkgs, username, ... }:
{
  imports = [
    ./modules/cache-cleanup.nix
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/neovim.nix
    ./modules/yazi.nix
    ./modules/podman.nix
    ./modules/dictation.nix
    ./modules/lockscreen.nix
    ./modules/ai-tools.nix
    ./modules/vscode.nix
    ./modules/packages
    ./modules/hyprland
    ./modules/theming
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}

