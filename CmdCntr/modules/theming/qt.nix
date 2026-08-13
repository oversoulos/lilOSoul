===== CmdCntr/modules/theming/qt.nix =====
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qt5ct
    qt6ct
    libsForQt5.qtstyleplugin-kvantum
  ];

  # Bridges Qt apps (Okular, etc.) into the same GTK theme, so they don't
  # look mismatched/default.
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
}