{ config, pkgs, lib, ... }:

let
  cfg = config.programs.mousepad;
in

{
  options.programs.mousepad = {
    enable = lib.mkEnableOption "Mousepad text editor";
    package = lib.mkPackageOption pkgs "mousepad" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
