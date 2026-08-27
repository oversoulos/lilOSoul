{ config, pkgs, lib, ... }:

let
  cfg = config.programs.rofi;
in

{
  options.programs.rofi = {
    enable = lib.mkEnableOption "Rofi app launcher";
    package = lib.mkPackageOption pkgs "rofi" { };
    theme = lib.mkOption {
      type = lib.types.str;
      default = "Dracula";
      description = "Rofi theme";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.etc."rofi/theme.rasi".text = ''
      @theme "${cfg.theme}"
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
