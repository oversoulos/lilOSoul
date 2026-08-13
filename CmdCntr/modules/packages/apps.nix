{ pkgs, ... }:
{
  # New app additions, locked in this pass.
  home.packages = with pkgs; [
    brave
    vesktop
    obs-studio
    obsidian
    xfce.thunar
    git-cola
    okular
  ];
}
