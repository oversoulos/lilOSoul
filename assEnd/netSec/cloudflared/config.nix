{ config, pkgs, lib, ... }:

let
  cfg = config.services.cloudflared;
in

{
  options.services.cloudflared = {
    enable = lib.mkEnableOption "Cloudflare Tunnel daemon";
    
    package = lib.mkPackageOption pkgs "cloudflared" { };
    
    tunnelId = lib.mkOption {
      type = lib.types.str;
      description = "Cloudflare Tunnel ID";
      example = "your-tunnel-id-here";
    };
    
    credentialsFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to tunnel credentials file";
      example = "/run/secrets/cloudflared-token";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    services.cloudflared = {
      enable = true;
      tunnels."${cfg.tunnelId}" = {
        credentialsFile = cfg.credentialsFile;
        default = "http_status:404";
      };
    };
    
    systemd.services."cloudflared-tunnel-${cfg.tunnelId}" = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other netSec modules.
}
