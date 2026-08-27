{ config, pkgs, lib, ... }:

let
  cfg = config.programs.spotify;
in

{
  options.programs.spotify = {
    enable = lib.mkEnableOption "Spotify music player";
    package = lib.mkPackageOption pkgs "spotify" { };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
