{ config, pkgs, lib, ... }:

let
  cfg = config.services.kdeconnect;
in

{
  options.services.kdeconnect = {
    enable = lib.mkEnableOption "KDE Connect phone integration";
    
    package = lib.mkPackageOption pkgs "kdePackages.kdeconnect-kde" { };
    
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Open firewall ports (1714-1764)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    services = {
      kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
    
    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; }
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; }
      ];
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other srvc/sys modules.
}
