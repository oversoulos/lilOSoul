{ config, pkgs, lib, ... }:

let
  cfg = config.programs.eza;
in

{
  options.programs.eza = {
    enable = lib.mkEnableOption "Eza modern ls replacement";
    
    package = lib.mkPackageOption pkgs "eza" { };
    
    icons = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Show icons";
    };
    
    colors = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Use colors";
    };
    
    git = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Show git status";
    };
    
    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        ls = "eza";
        l = "eza -l";
        la = "eza -la";
        ll = "eza -la --git";
        tree = "eza --tree";
      };
      description = "Shell aliases";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.shellAliases = cfg.aliases;
    
    programs.bash.interactiveShellInit = lib.mkIf (cfg.icons || cfg.colors) ''
      export EZA_ICONS=${if cfg.icons then "1" else "0"}
      export EZA_COLORS=${if cfg.colors then "auto" else "never"}
      export EZA_GIT=${if cfg.git then "1" else "0"}
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
