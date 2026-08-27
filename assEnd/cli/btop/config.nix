{ config, pkgs, lib, ... }:

let
  cfg = config.programs.btop;
  format = pkgs.formats.toml { };
in

{
  options.programs.btop = {
    enable = lib.mkEnableOption "btop system monitor";
    
    package = lib.mkPackageOption pkgs "btop" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "btop configuration";
      example = {
        color_theme = "dracula";
        show_gpu_info = true;
        update_ms = 1000;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."btop/btop.conf".source = lib.mkIf (cfg.settings != { }) (
      format.generate "btop.conf" cfg.settings
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
