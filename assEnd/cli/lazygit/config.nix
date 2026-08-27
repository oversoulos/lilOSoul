{ config, pkgs, lib, ... }:

let
  cfg = config.programs.lazygit;
  format = pkgs.formats.yaml { };
in

{
  options.programs.lazygit = {
    enable = lib.mkEnableOption "lazygit terminal UI for git";
    
    package = lib.mkPackageOption pkgs "lazygit" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "lazygit configuration";
      example = {
        gui = {
          theme = {
            lightTheme = false;
            activeBorderColor = [ "green" "bold" ];
          };
          showCommandLog = true;
        };
        git = {
          autoFetch = true;
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          };
        };
        os = {
          editCommand = "nvim";
          editCommandTemplate = "nvim {{filename}}";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."xdg/lazygit/config.yml".source = lib.mkIf (cfg.settings != { }) (
      format.generate "lazygit-config.yml" cfg.settings
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
