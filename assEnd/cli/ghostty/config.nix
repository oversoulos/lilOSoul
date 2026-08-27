{ config, pkgs, lib, ... }:

let
  cfg = config.programs.ghostty;
  format = pkgs.formats.keyValue { listsAsDuplicateKeys = true; };
in

{
  options.programs.ghostty = {
    enable = lib.mkEnableOption "Ghostty terminal emulator";
    
    package = lib.mkPackageOption pkgs "ghostty" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "Ghostty configuration";
      example = {
        theme = "dracula";
        font-family = "JetBrainsMono Nerd Font";
        font-size = 12;
        background-opacity = 0.98;
        background-blur-radius = 40;
        cursor-style = "block";
        window-decoration = true;
        shell-integration = "zsh";
        copy-on-select = true;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."ghostty/config".source = lib.mkIf (cfg.settings != { }) (
      format.generate "ghostty-config" cfg.settings
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
