{ config, pkgs, lib, ... }:

let
  cfg = config.services.nntp-proxy;
in

{
  options.services.nntp-proxy = {
    enable = lib.mkEnableOption "NNTP Proxy (Usenet)";
    
    package = lib.mkPackageOption pkgs "nntp-proxy" { };
    
    upstreamServer = lib.mkOption {
      type = lib.types.str;
      description = "Upstream NNTP server address";
      example = "ssl-eu.astraweb.com";
    };
    
    upstreamPort = lib.mkOption {
      type = lib.types.port;
      default = 563;
      description = "Upstream NNTP server port";
    };
    
    upstreamUser = lib.mkOption {
      type = lib.types.str;
      description = "Upstream server username";
    };
    
    upstreamPassword = lib.mkOption {
      type = lib.types.str;
      description = "Upstream server password";
    };
    
    listenAddress = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1";
      description = "Proxy listen address";
    };
    
    port = lib.mkOption {
      type = lib.types.port;
      default = 5555;
      description = "Proxy listen port";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    systemd.services.nntp-proxy = {
      description = "NNTP Proxy";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''
          ${cfg.package}/bin/nntp-proxy \
            --server ${cfg.upstreamServer} \
            --port ${toString cfg.upstreamPort} \
            --user ${cfg.upstreamUser} \
            --pass ${cfg.upstreamPassword} \
            --bind ${cfg.listenAddress} \
            --bind-port ${toString cfg.port}
        '';
        User = "nntp-proxy";
        Restart = "always";
      };
    };
    
    users.users.nntp-proxy = {
      isSystemUser = true;
      group = "nntp-proxy";
    };
    users.groups.nntp-proxy = { };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other netSec modules.
}
