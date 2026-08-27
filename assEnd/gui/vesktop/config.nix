{ config, pkgs, lib, ... }:

let
  cfg = config.programs.vesktop;
in

{
  options.programs.vesktop = {
    enable = lib.mkEnableOption "Vesktop Discord client (with Vencord)";
    package = lib.mkPackageOption pkgs "vesktop" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
