===== CmnCntr/modules/theming/cursors.nix =====
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bibata-cursors
    numix-cursor-theme
  ];
}