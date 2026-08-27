{ config, pkgs, lib, ... }:

let
  cfg = config.programs.foot;
in

{
  options.programs.foot = {
    enable = lib.mkEnableOption "Foot terminal (dropdown mode)";
    package = lib.mkPackageOption pkgs "foot" { };
    quickShell = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable dropdown/quick shell mode";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    programs.foot.enable = true;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
