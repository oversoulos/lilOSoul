{ ... }:
{
  # dconf — needed for several GTK apps (Thunar included) to save and
  # persist their settings correctly under Wayland/Hyprland.
  programs.dconf.enable = true;

  # gvfs — gives Thunar (and other GTK file tools) trash support, mounting
  # removable drives, and network locations. Without this, Thunar runs but
  # several right-click actions silently don't work.
  services.gvfs.enable = true;
}
