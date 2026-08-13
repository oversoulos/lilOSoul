{ pkgs, ... }:
{
  home.packages = with pkgs; [
    imv   # image viewer
    mpv   # video/media player
  ];
}
