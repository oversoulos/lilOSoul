{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Cursor themes
    bibata-cursors
    bibata-cursors-extra
    capitaine-cursors
    catppuccin-cursors
    numix-cursor-theme
    nordic-cursors
    phinger-cursors
    vanilla-dmz
    volantes-cursors
    white-cursor-theme
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}