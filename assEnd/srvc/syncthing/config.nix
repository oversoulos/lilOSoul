{ config, pkgs, lib, ... }:

let
  cfg = config.services.syncthing;
in

{
  options.services.syncthing = {
    enable = lib.mkEnableOption "Syncthing file synchronization";
    
    package = lib.mkPackageOption pkgs "syncthing" { };
    
    user = lib.mkOption {
      type = lib.types.str;
      default = "syncthing";
      description = "User to run Syncthing as";
    };
    
    group = lib.mkOption {
      type = lib.types.str;
      default = "syncthing";
      description = "Group to run Syncthing as";
    };
    
    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Open firewall ports (22000, 21027)";
    };
    
    devices = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          id = lib.mkOption {
            type = lib.types.str;
            description = "Device ID";
          };
          addresses = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Device addresses";
          };
        };
      });
      default = { };
      description = "Syncthing devices";
      example = {
        laptop = {
          id = "XXXXX-XXXXX-XXXXX";
          addresses = [ "tcp://laptop.local:22000" ];
        };
      };
    };
    
    folders = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          path = lib.mkOption {
            type = lib.types.str;
            description = "Folder path";
          };
          devices = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Devices to share with";
          };
        };
      });
      default = { };
      description = "Syncthing folders";
      example = {
        documents = {
          path = "/home/user/Documents";
          devices = [ "laptop" ];
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    services.syncthing = {
      enable = true;
      user = cfg.user;
      group = cfg.group;
      openDefaultPorts = cfg.openFirewall;
      configDir = "/var/lib/syncthing";
      dataDir = "/var/lib/syncthing";
      
      settings = {
        devices = cfg.devices;
        folders = cfg.folders;
        options = {
          urAccepted = -1;
          localAnnounceEnabled = false;
          globalAnnounceEnabled = false;
          natEnabled = false;
          relaysEnabled = false;
        };
      };
    };
    
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = "/var/lib/syncthing";
      createHome = true;
    };
    
    users.groups.${cfg.group} = { };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other srvc/sys modules.
}
