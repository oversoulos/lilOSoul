{ config, pkgs, lib, ... }:

let
  cfg = config.programs.mission-center;
in

{
  options.programs.mission-center = {
    enable = lib.mkEnableOption "Mission Center system monitor";
    package = lib.mkPackageOption pkgs "mission-center" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
