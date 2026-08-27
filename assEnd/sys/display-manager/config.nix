{ config, pkgs, lib, username, ... }:

let
  cfg = config.services.displayManager;
in

{
  options.services.displayManager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable SDDM display manager";
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
    
    theme = lib.mkOption {
      type = lib.types.str;
      default = "breeze";
      description = "SDDM theme";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = cfg.theme;
      wayland.enable = true;
    };
    
    services.displayManager.autoLogin = lib.mkIf cfg.autoLogin {
      enable = true;
      user = cfg.autoLoginUser;
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
