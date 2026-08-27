{ config, pkgs, lib, ... }:

let
  cfg = config.services.dnscrypt-proxy;
  settingsFormat = pkgs.formats.toml { };
  configFile = settingsFormat.generate "dnscrypt-proxy.toml" cfg.settings;
in

{
  options.services.dnscrypt-proxy = {
    enable = lib.mkEnableOption "DNSCrypt-proxy DNS encryption";

    package = lib.mkPackageOption pkgs "dnscrypt-proxy" { };

    settings = lib.mkOption {
      type = settingsFormat.type;
      default = { };
      description = "DNSCrypt-proxy configuration (TOML)";
      example = {
        sources.public-resolvers = {
          urls = [ "https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md" ];
          cache_file = "public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          refresh_delay = 72;
        };
      };
    };

    upstreamDefaults = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use upstream default configuration as base";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.nameservers = [ "127.0.0.1" ];

    environment.systemPackages = [ cfg.package ];

    systemd.services.dnscrypt-proxy = {
      description = "DNSCrypt-proxy client";
      wants = [ "network-online.target" "nss-lookup.target" ];
      before = [ "nss-lookup.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        AmbientCapabilities = "CAP_NET_BIND_SERVICE";
        DynamicUser = true;
        ExecStart = "${cfg.package}/bin/dnscrypt-proxy -config ${configFile}";
        Restart = "always";
        PrivateTmp = true;
        ProtectSystem = "strict";
        ProtectHome = true;
      };
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidate: pulling upstream default TOML
  # (dnscrypt-proxy's own example config) as a base layer when
  # upstreamDefaults = true, instead of that option currently doing nothing.
}
