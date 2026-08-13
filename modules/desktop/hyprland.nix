{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  security.pam.services.hyprlock = { };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps (Discord/Vesktop, OBS, etc.) use Wayland
  };
}
