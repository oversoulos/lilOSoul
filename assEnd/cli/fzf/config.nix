{ config, pkgs, lib, ... }:

let
  cfg = config.programs.fzf;
  format = pkgs.formats.yaml { };
in

{
  options.programs.fzf = {
    enable = lib.mkEnableOption "Fzf fuzzy finder";
    
    package = lib.mkPackageOption pkgs "fzf" { };
    
    defaultOptions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "--height 40%" "--border" ];
      description = "Default fzf options";
    };
    
    colors = lib.mkOption {
      type = format.type;
      default = { };
      description = "Fzf colors";
      example = {
        fg = "#f8f8f2";
        bg = "#282a36";
        hl = "#bd93f9";
        "fg+" = "#f8f8f2";
        "bg+" = "#44475a";
        "hl+" = "#bd93f9";
        info = "#ffb86c";
        prompt = "#50fa7b";
        pointer = "#ff79c6";
        marker = "#ff79c6";
        spinner = "#ffb86c";
        header = "#6272a4";
      };
    };
    
    enableBashIntegration = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Bash integration";
    };
    
    enableZshIntegration = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Zsh integration";
    };
    
    tmux = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable tmux integration";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."fzf/colors.yml".source = lib.mkIf (cfg.colors != { }) (
      format.generate "fzf-colors.yml" cfg.colors
    );
    
    programs.bash.interactiveShellInit = lib.mkIf cfg.enableBashIntegration ''
      source ${cfg.package}/share/fzf/completion.bash
      source ${cfg.package}/share/fzf/key-bindings.bash
    '';
    
    programs.zsh.interactiveShellInit = lib.mkIf cfg.enableZshIntegration ''
      source ${cfg.package}/share/fzf/completion.zsh
      source ${cfg.package}/share/fzf/key-bindings.zsh
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
