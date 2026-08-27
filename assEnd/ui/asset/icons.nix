{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Complete icon sets
    papirus-icon-theme
    papirus-folders
    tela-icon-theme
    tela-circle-icon-theme
    whitesur-icon-theme
    qogir-icon-theme
    numix-icon-theme
    numix-icon-theme-circle
    zafiro-icons
    beauty-line-icon-theme
    material-icons
    candy-icons
    fluent-icon-theme
    reversal-icon-theme
    colloid-icon-theme
    
    # Additional icon sets
    adwaita-icon-theme
    breeze-icons
    elementary-icon-theme
    gnome-icon-theme
    gnome-icon-theme-extras
    hicolor-icon-theme
    mate-icon-theme
    moka-icon-theme
    oxygen-icons
    tango-icon-theme
  ];
}