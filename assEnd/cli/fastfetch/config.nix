{ config, pkgs, lib, ... }:

let
  cfg = config.programs.fastfetch;
  format = pkgs.formats.json { };
in

{
  options.programs.fastfetch = {
    enable = lib.mkEnableOption "fastfetch system info tool";
    
    package = lib.mkPackageOption pkgs "fastfetch" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "fastfetch configuration";
      example = {
        display = {
          separator = "  ";
          color = {
            keys = "yellow";
            values = "white";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."fastfetch/config.jsonc".source = lib.mkIf (cfg.settings != { }) (
      format.generate "fastfetch-config.jsonc" cfg.settings
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
