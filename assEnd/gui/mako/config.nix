{ config, pkgs, lib, ... }:

let
  cfg = config.programs.mako;
  format = pkgs.formats.ini { };
in

{
  options.programs.mako = {
    enable = lib.mkEnableOption "Mako notification daemon";
    package = lib.mkPackageOption pkgs "mako" { };
    settings = lib.mkOption {
      type = format.type;
      default = {
        default = {
          font = "JetBrainsMono Nerd Font 12";
          background-color = "#282a36";
          text-color = "#f8f8f2";
          border-color = "#bd93f9";
          border-size = 2;
          width = 300;
        };
      };
      description = "Mako configuration";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc."xdg/mako/config".source = lib.mkIf (cfg.settings != { }) (
      format.generate "mako-config" cfg.settings
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
