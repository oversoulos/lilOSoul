{ config, pkgs, lib, ... }:

let
  cfg = config.programs.okular;
in

{
  options.programs.okular = {
    enable = lib.mkEnableOption "Okular document viewer (PDF)";
    package = lib.mkPackageOption pkgs "okular" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
