{ config, pkgs, lib, ... }:

let
  cfg = config.programs.ripgrep;
in

{
  options.programs.ripgrep = {
    enable = lib.mkEnableOption "ripgrep recursive search tool";
    
    package = lib.mkPackageOption pkgs "ripgrep" { };
    
    config = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "ripgrep configuration (rgrc format)";
      example = ''
        # Smart-case search
        --smart-case
        # Always show line numbers
        --line-number
        # Respect .gitignore
        --ignore-file .gitignore
        # Colors
        --colors "match:fg:green"
        --colors "line:fg:blue"
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."rgrc".text = lib.mkIf (cfg.config != "") cfg.config;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
