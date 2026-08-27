{ config, pkgs, lib, ... }:

let
  cfg = config.programs.sillytavern;
in

{
  options.programs.sillytavern = {
    enable = lib.mkEnableOption "SillyTavern AI chat frontend";
    package = lib.mkPackageOption pkgs "sillytavern" { };
    port = lib.mkOption {
      type = lib.types.port;
      default = 8000;
      description = "Web UI port";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    environment.sessionVariables.SILLYTAVERN_PORT = toString cfg.port;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: a systemd service
  # for always-on operation, or cross-module hooks with the rest
  # of molecular/AI.
}
