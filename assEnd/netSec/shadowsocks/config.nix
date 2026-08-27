{ config, pkgs, lib, ... }:

let
  cfg = config.services.shadowsocks;
in

{
  options.services.shadowsocks = {
    enable = lib.mkEnableOption "Shadowsocks SOCKS5 proxy";
    
    package = lib.mkPackageOption pkgs "shadowsocks-libev" { };
    
    server = lib.mkOption {
      type = lib.types.str;
      default = "0.0.0.0";
      description = "Server bind address";
    };
    
    port = lib.mkOption {
      type = lib.types.port;
      default = 8388;
      description = "Server port";
    };
    
    password = lib.mkOption {
      type = lib.types.str;
      description = "Proxy password";
      example = "your-password-here";
    };
    
    method = lib.mkOption {
      type = lib.types.str;
      default = "chacha20-ietf-poly1305";
      description = "Encryption method";
    };
    
    mode = lib.mkOption {
      type = lib.types.enum [ "tcp_only" "tcp_and_udp" "udp_only" ];
      default = "tcp_and_udp";
      description = "Protocol mode";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    systemd.services.shadowsocks = {
      description = "Shadowsocks SOCKS5 Proxy";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''
          ${cfg.package}/bin/ss-server \
            -s ${cfg.server} \
            -p ${toString cfg.port} \
            -k ${cfg.password} \
            -m ${cfg.method} \
            -u
        '';
        Restart = "always";
        PrivateTmp = true;
      };
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other netSec modules.
}
