{ config, pkgs, lib, ... }:

let
  cfg = config.programs.onlyoffice;
in

{
  options.programs.onlyoffice = {
    enable = lib.mkEnableOption "OnlyOffice desktop editors";
    package = lib.mkPackageOption pkgs "onlyoffice-desktopeditors" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
