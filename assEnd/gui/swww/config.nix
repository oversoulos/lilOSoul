{ config, pkgs, lib, ... }:

let
  cfg = config.programs.swww;
in

{
  options.programs.swww = {
    enable = lib.mkEnableOption "Swww wallpaper daemon";
    package = lib.mkPackageOption pkgs "swww" { };
    autoStart = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Auto-start with Hyprland";
    };
    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Default wallpaper path";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    services.swww.enable = cfg.autoStart;
    environment.etc."swww/wallpaper".source = lib.mkIf (cfg.wallpaper != null) cfg.wallpaper;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
