{ config, pkgs, lib, username, ... }:

let
  cfg = config.services.greetd;
in

{
  options.services.greetd = {
    enable = lib.mkEnableOption "Greetd display manager (lightweight)";
    
    package = lib.mkPackageOption pkgs "greetd" { };
    
    greeter = lib.mkOption {
      type = lib.types.package;
      default = pkgs.greetd.regreet;
      description = "Greeter package to use";
    };
    
    defaultSession = lib.mkOption {
      type = lib.types.str;
      default = "Hyprland";
      description = "Default desktop session";
    };
    
    autoLogin = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable auto-login";
    };
    
    autoLoginUser = lib.mkOption {
      type = lib.types.str;
      default = username;
      description = "User to auto-login";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package cfg.greeter ];
    
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${cfg.defaultSession}";
          user = cfg.autoLoginUser;
        };
      };
    };
    
    services.greetd.settings.initial_session = lib.mkIf cfg.autoLogin {
      command = "${cfg.defaultSession}";
      user = cfg.autoLoginUser;
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
