{ config, pkgs, lib, ... }:

let
  cfg = config.programs.thunar;
in

{
  options.programs.thunar = {
    enable = lib.mkEnableOption "Thunar file manager";
    package = lib.mkPackageOption pkgs "thunar" { };
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        xfce.thunar-archive-plugin
      ];
      description = "Thunar plugins";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.thunar.override { thunarPlugins = cfg.plugins; })
    ];
    services.dbus.packages = [ cfg.package ];
    programs.xfconf.enable = true;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
