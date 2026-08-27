{
  imports = [
    ../gui/imv
    ../gui/mission-center
    ../gui/obs-studio
    ../gui/swww
    ../gui/okular
    ../gui/mako
    ../gui/foot
    ../gui/insomnia
    ../gui/ewww
    ../gui/spotify
    ../gui/thunar
    ../gui/dbeaver
    ../gui/waybar
    ../gui/onlyoffice
    ../gui/vlc
    ../gui/your-spotify
    ../gui/mousepad
    ../gui/rofi
    ../gui/obsidian
    ../gui/pdfarranger
    ../gui/vscode
    ../gui/vesktop
  ];

  # ./bitwarden is intentionally not imported -- that module folder exists
  # but is currently empty (skipped per your instruction). Importing an
  # empty folder with no default.nix would break the build, so it's left
  # out of this list until bitwarden is actually built.
}
