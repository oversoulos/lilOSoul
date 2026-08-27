{ config, pkgs, lib, ... }:

let
  cfg = config.programs.dbeaver;
in

{
  options.programs.dbeaver = {
    enable = lib.mkEnableOption "DBeaver database client";
    package = lib.mkPackageOption pkgs "dbeaver" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
