===== CmdCntr/modules/theming/icons.nix =====
{ pkgs, ... }:
{
  # All installed and swappable live via nwg-look. Papirus-Dark is the
  # declared default (what's active after a fresh rebuild).
  home.packages = with pkgs; [
    papirus-icon-theme
    tela-icon-theme
    whitesur-icon-theme
    qogir-icon-theme
  ];
}