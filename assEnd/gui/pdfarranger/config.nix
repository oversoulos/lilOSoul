{ config, pkgs, lib, ... }:

let
  cfg = config.programs.pdfarranger;
in

{
  options.programs.pdfarranger = {
    enable = lib.mkEnableOption "PDF Arranger - merge/split/rearrange PDFs";
    package = lib.mkPackageOption pkgs "pdfarranger" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
