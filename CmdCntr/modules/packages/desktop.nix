{ pkgs, ... }:
{
  # Core desktop utility packages Hyprland's own config relies on
  # (screenshotting, clipboard, applets, theme/display GUIs).
  home.packages = with pkgs; [
    wofi
    wl-clipboard
    grim
    slurp
    swappy
    networkmanagerapplet
    blueman
    pavucontrol
    nwg-look
    wdisplays
    swww
    mako
    cliphist
    brightnessctl
    wlogout
    radeontop
    vulkan-tools
    qt5ct
    qt6ct
    libsForQt5.qtstyleplugin-kvantum
    papirus-icon-theme
    tela-icon-theme
    whitesur-icon-theme
    qogir-icon-theme
    bibata-cursors
    numix-cursor-theme
  ];
}

