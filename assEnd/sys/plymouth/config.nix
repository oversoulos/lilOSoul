{ config, pkgs, lib, ... }:

let
  cfg = config.services.plymouth;
in

{
  options.services.plymouth = {
    enable = lib.mkEnableOption "Plymouth boot splash screen";
    
    theme = lib.mkOption {
      type = lib.types.str;
      default = "spinner";
      description = "Plymouth theme";
    };
    
    logo = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Custom logo image";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      theme = cfg.theme;
      logo = cfg.logo;
    };
    
    boot.initrd.systemd.enable = true;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
