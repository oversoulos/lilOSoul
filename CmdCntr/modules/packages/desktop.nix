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
  ];
}

