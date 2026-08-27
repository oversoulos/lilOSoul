{ config, pkgs, lib, ... }:

let
  cfg = config.programs.yazi;
  format = pkgs.formats.toml { };
in

{
  options.programs.yazi = {
    enable = lib.mkEnableOption "Yazi terminal file manager";
    
    package = lib.mkPackageOption pkgs "yazi" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "Yazi settings (yazi.toml)";
      example = {
        manager = {
          show_hidden = true;
          sort_by = "alphabetical";
          sort_dir_first = true;
          linemode = "size";
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
          image_filter = "lanczos3";
          image_quality = 90;
        };
        file = {
          sort_by = "modified";
          sort_reverse = false;
        };
      };
    };
    
    keymap = lib.mkOption {
      type = format.type;
      default = { };
      description = "Yazi keymap (keymap.toml)";
      example = {
        manager = {
          keymap = [
            { on = [ "r" ]; run = "reload"; }
            { on = [ "R" ]; run = "rename"; }
          ];
        };
      };
    };
    
    theme = lib.mkOption {
      type = format.type;
      default = { };
      description = "Yazi theme (theme.toml)";
      example = {
        manager = {
          cwd = "#bd93f9";
          hovered = "#44475a";
        };
        file = {
          regular = "#f8f8f2";
          directory = "#50fa7b";
          executable = "#ffb86c";
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
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
      pkgs.poppler      # PDF previews
      pkgs.resvg        # SVG previews
      pkgs.imagemagick  # Image previews
      pkgs.ffmpeg       # Video previews
      pkgs.jq           # JSON previews
      pkgs.zoxide       # Fast directory jumping
    ];
    
    environment.etc."yazi/yazi.toml".source = lib.mkIf (cfg.settings != { }) (
      format.generate "yazi.toml" cfg.settings
    );
    
    environment.etc."yazi/keymap.toml".source = lib.mkIf (cfg.keymap != { }) (
      format.generate "keymap.toml" cfg.keymap
    );
    
    environment.etc."yazi/theme.toml".source = lib.mkIf (cfg.theme != { }) (
      format.generate "theme.toml" cfg.theme
    );
    
    programs.bash.interactiveShellInit = lib.mkIf cfg.enableBashIntegration ''
      ${cfg.package}/bin/ya bash-init
    '';
    
    programs.zsh.interactiveShellInit = lib.mkIf cfg.enableZshIntegration ''
      ${cfg.package}/bin/ya zsh-init
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
