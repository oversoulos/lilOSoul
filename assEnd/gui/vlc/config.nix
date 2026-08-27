{ config, pkgs, lib, ... }:

let
  cfg = config.programs.vlc;
in

{
  options.programs.vlc = {
    enable = lib.mkEnableOption "VLC media player";
    package = lib.mkPackageOption pkgs "vlc" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
