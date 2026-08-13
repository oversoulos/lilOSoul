{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  # Bridges Qt apps (Okular, etc.) into the same GTK theme, so they don't
  # look mismatched/default. qt5ct/qt6ct + Kvantum are the packages that
  # make this possible (added in packages/desktop.nix).
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
}



