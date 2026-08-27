{ config, pkgs, lib, ... }:

let
  cfg = config.programs.starship;
  format = pkgs.formats.toml { };
in

{
  options.programs.starship = {
    enable = lib.mkEnableOption "Starship cross-shell prompt";
    
    package = lib.mkPackageOption pkgs "starship" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "Starship configuration (toml format)";
      example = {
        add_newline = false;
        format = "$directory$git_branch$git_status$character";
        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[x](bold red)";
        };
        directory = {
          style = "bold cyan";
          truncation_length = 3;
        };
        git_branch = {
          style = "bold purple";
          symbol = " ";
        };
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
    
    enableFishIntegration = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Fish integration";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."starship.toml".source = lib.mkIf (cfg.settings != { }) (
      format.generate "starship.toml" cfg.settings
    );
    
    programs.bash.interactiveShellInit = lib.mkIf cfg.enableBashIntegration ''
      eval "$(${cfg.package}/bin/starship init bash)"
    '';
    
    programs.zsh.interactiveShellInit = lib.mkIf cfg.enableZshIntegration ''
      eval "$(${cfg.package}/bin/starship init zsh)"
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
