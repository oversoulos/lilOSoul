{ config, pkgs, lib, ... }:

let
  cfg = config.programs.ewww;
in

{
  options.programs.ewww = {
    enable = lib.mkEnableOption "Ewww widget system";
    package = lib.mkPackageOption pkgs "eww" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
