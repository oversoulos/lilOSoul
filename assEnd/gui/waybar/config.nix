{ config, pkgs, lib, ... }:

let
  cfg = config.programs.waybar;
  format = pkgs.formats.json { };
in

{
  options.programs.waybar = {
    enable = lib.mkEnableOption "Waybar status bar";
    package = lib.mkPackageOption pkgs "waybar" { };
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "Waybar configuration";
      example = {
        layer = "top";
        position = "top";
        modules = [ "hyprland/workspaces" "clock" ];
      };
    };
    style = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Waybar CSS style";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc."xdg/waybar/config".source = lib.mkIf (cfg.settings != { }) (
      format.generate "waybar-config" cfg.settings
    );
    environment.etc."xdg/waybar/style.css".text = lib.mkIf (cfg.style != "") cfg.style;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
