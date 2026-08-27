{ config, pkgs, lib, ... }:

let
  cfg = config.services.podman;
in

{
  options.services.podman = {
    enable = lib.mkEnableOption "Podman container engine (CLI installed)";
    
    enableService = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Podman system service (runs in background)";
    };
    
    package = lib.mkPackageOption pkgs "podman" { };
    
    rootless = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Run containers as user (rootless)";
    };
    
    autoStart = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Containers to auto-start on boot";
      example = [ "nginx" "postgres" ];
    };
    
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ podman-compose buildah skopeo ];
      description = "Additional container management tools";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ] ++ cfg.extraPackages;
    
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    
    systemd.services.podman = lib.mkIf cfg.enableService {
      description = "Podman API Service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/podman system service --time=0";
        Restart = "always";
        RestartSec = "5s";
        User = if cfg.rootless then "1000" else "root";
      };
    };
    
    users.extraGroups.podman = lib.mkIf cfg.rootless { };
    
    environment.etc."containers/containers.conf".text = ''
      [containers]
      rootless = "${if cfg.rootless then "true" else "false"}"
      dns_servers = [ "1.1.1.1", "8.8.8.8" ]
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other srvc/sys modules.
}
