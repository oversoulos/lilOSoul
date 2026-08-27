{ config, pkgs, lib, ... }:

let
  cfg = config.services.tailscale;
in

{
  options.services.tailscale = {
    enable = lib.mkEnableOption "Tailscale VPN";
    
    package = lib.mkPackageOption pkgs "tailscale" { };
    
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Open Tailscale ports in firewall";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    services.tailscale = {
      enable = true;
      openFirewall = cfg.openFirewall;
    };
    
    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedUDPPorts = [ 41641 ];
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
