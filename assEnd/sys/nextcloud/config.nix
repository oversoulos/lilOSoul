{ config, pkgs, lib, ... }:

let
  cfg = config.services.nextcloud-client;
in

{
  options.services.nextcloud-client = {
    enable = lib.mkEnableOption "Nextcloud desktop sync client";
    
    package = lib.mkPackageOption pkgs "nextcloud-client" { };
    
    autoStart = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Auto-start Nextcloud client";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    systemd.user.services.nextcloud = lib.mkIf cfg.autoStart {
      description = "Nextcloud Desktop Client";
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/nextcloud";
        Restart = "on-failure";
      };
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
