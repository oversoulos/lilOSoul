{ config, pkgs, lib, ... }:

let
  cfg = config.programs.vscode;
  jsonFormat = pkgs.formats.json { };
in

{
  options.programs.vscode = {
    enable = lib.mkEnableOption "VSCode editor";
    package = lib.mkPackageOption pkgs "vscode" { };
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Set as default editor";
    };
    extensions = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs.vscode-extensions; [
        ms-python.python
        vscodevim.vim
      ];
      description = "VSCode extensions";
    };
    settings = lib.mkOption {
      type = jsonFormat.type;
      default = {
        "editor.fontSize" = 14;
        "workbench.colorTheme" = "Default Dark+";
      };
      description = "User settings";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.vscode-with-extensions.override {
        vscode = cfg.package;
        vscodeExtensions = cfg.extensions;
      })
    ];
    environment.sessionVariables.EDITOR = lib.mkIf cfg.defaultEditor "code";
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
