===== CmdCntr/modules/theming/gtk-themes.nix =====
{ pkgs, ... }:
{
  # Color-scheme "families" — installed so you can browse/swap live via
  # nwg-look. Confirmed real nixpkgs package names (checked directly, not
  # guessed). Dracula/Everforest weren't independently confirmed — search
  # search.nixos.org/packages if you want to add those too.
  home.packages = with pkgs; [
    catppuccin-gtk
    rose-pine-gtk-theme
    nordic          # this is the real package name for the Nord GTK theme
    gruvbox-gtk-theme
  ];
}
