{ config, pkgs, lib, ... }:

let
  cfg = config.services.bookstack;
in

{
  options.services.bookstack = {
    enable = lib.mkEnableOption "Bookstack documentation wiki";
    
    package = lib.mkPackageOption pkgs "bookstack" { };
    
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "bookstack.local";
      description = "Hostname for Bookstack";
    };
    
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/bookstack";
      description = "Bookstack data directory";
    };
    
    user = lib.mkOption {
      type = lib.types.str;
      default = "bookstack";
      description = "User to run Bookstack as";
    };
    
    group = lib.mkOption {
      type = lib.types.str;
      default = "bookstack";
      description = "Group to run Bookstack as";
    };
    
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Bookstack environment settings";
      example = {
        APP_ENV = "production";
        DB_HOST = "localhost";
        DB_DATABASE = "bookstack";
        DB_USERNAME = "bookstack";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    services.phpfpm.pools.bookstack = {
      inherit (cfg) user group;
      settings = {
        "listen.mode" = "0660";
        "listen.owner" = cfg.user;
        "listen.group" = cfg.group;
        "pm" = "dynamic";
        "pm.max_children" = 32;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 2;
        "pm.max_spare_servers" = 4;
        "pm.max_requests" = 500;
      };
    };
    
    services.nginx = {
      enable = true;
      virtualHosts.${cfg.hostname} = {
        root = "${cfg.package}/public";
        locations."/" = {
          index = "index.php";
          tryFiles = "$uri $uri/ /index.php?$query_string";
        };
        locations."~ \\.php$" = {
          extraConfig = ''
            include ${config.services.nginx.package}/conf/fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $request_filename;
            fastcgi_pass unix:${config.services.phpfpm.pools."bookstack".socket};
          '';
        };
      };
    };
    
    systemd.tmpfiles.settings."10-bookstack" = {
      "${cfg.dataDir}".d = {
        inherit (cfg) user group;
        mode = "0710";
      };
    };
    
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.dataDir;
      createHome = true;
    };
    
    users.groups.${cfg.group} = { };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other srvc/sys modules.
}
