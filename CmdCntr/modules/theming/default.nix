===== CmdCntr/modules/theming/defaults.nix =====
{ pkgs, ... }:
{
  # This is the ONE file that decides what's actually active after a
  # fresh rebuild. Everything else in this folder just makes options
  # available to browse/swap live via nwg-look — this file is the lock-in.
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
}

===== CmdCntr/modules/theming/default.nix =====
{
  imports = [
    ./icons.nix
    ./cursors.nix
    ./gtk-themes.nix
    ./qt.nix
    ./defaults.nix
  ];
}

