{ config, pkgs, lib, ... }:

let
  cfg = config.services.ydotool;
in

{
  options.services.ydotool = {
    enable = lib.mkEnableOption "ydotool keyboard/mouse automation daemon";
    
    package = lib.mkPackageOption pkgs "ydotool" { };
    
    group = lib.mkOption {
      type = lib.types.str;
      default = "ydotool";
      description = "Group to allow ydotool access";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    users.groups.${cfg.group} = { };
    
    systemd.services.ydotoold = {
      description = "ydotoold - backend for ydotool";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Group = cfg.group;
        RuntimeDirectory = "ydotoold";
        RuntimeDirectoryMode = "0750";
        ExecStart = "${cfg.package}/bin/ydotoold --socket-path=/run/ydotoold/socket --socket-perm=0660";
        DeviceAllow = [ "/dev/uinput" ];
        DevicePolicy = "closed";
        RestrictAddressFamilies = [ "AF_UNIX" ];
        CapabilityBoundingSet = "";
        NoNewPrivileges = true;
        PrivateTmp = true;
        PrivateUsers = true;
        ProtectSystem = "strict";
        ProtectHome = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        RestrictNamespaces = true;
      };
    };
    
    environment.variables.YDOTOOL_SOCKET = "/run/ydotoold/socket";
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks with other srvc/sys modules.
}
