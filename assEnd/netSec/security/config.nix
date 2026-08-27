{ config, pkgs, lib, ... }:

let
  cfg = config.molecular.security;
in

{
  options.molecular.security = {
    enable = lib.mkEnableOption "Network security toolkit";
    
    tailscale = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Tailscale VPN";
    };
    
    privoxy = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Privoxy HTTP proxy";
    };
    
    tools = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        wireguard-tools
        mullvad-vpn
        tailscale
        nmap
        tcpdump
        curl
        aria2
        git-lfs
      ];
      description = "Network security tools to install";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = cfg.tools;
    
    services.tailscale.enable = cfg.tailscale;
    services.privoxy.enable = cfg.privoxy;
    programs.git.lfs.enable = true;
    
    networking.firewall = lib.mkIf cfg.tailscale {
      allowedUDPPorts = [ 51820 ];
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other netSec modules.
}
