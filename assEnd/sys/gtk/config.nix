{ config, pkgs, lib, ... }:

let
  cfg = config.programs.gtk;
in

{
  options.programs.gtk = {
    enable = lib.mkEnableOption "GTK theming configuration";
    
    theme = lib.mkOption {
      type = lib.types.attrs;
      default = {
        name = "Dracula";
        package = pkgs.dracula-theme;
      };
      description = "GTK theme";
    };
    
    iconTheme = lib.mkOption {
      type = lib.types.attrs;
      default = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      description = "GTK icon theme";
    };
    
    cursorTheme = lib.mkOption {
      type = lib.types.attrs;
      default = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };
      description = "GTK cursor theme";
    };
    
    font = lib.mkOption {
      type = lib.types.attrs;
      default = {
        name = "Noto Sans 11";
        package = pkgs.noto-fonts;
      };
      description = "GTK font";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.theme.package
      cfg.iconTheme.package
      cfg.cursorTheme.package
      cfg.font.package
    ];
    
    gtk = {
      enable = true;
      theme = {
        name = cfg.theme.name;
        package = cfg.theme.package;
      };
      iconTheme = {
        name = cfg.iconTheme.name;
        package = cfg.iconTheme.package;
      };
      cursorTheme = {
        name = cfg.cursorTheme.name;
        package = cfg.cursorTheme.package;
      };
      font = {
        name = cfg.font.name;
        package = cfg.font.package;
      };
    };
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
