{ config, pkgs, lib, ... }:

let
  cfg = config.programs.imv;
in

{
  options.programs.imv = {
    enable = lib.mkEnableOption "imv image viewer";
    package = lib.mkPackageOption pkgs "imv" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
