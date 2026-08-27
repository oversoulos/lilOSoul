{ config, pkgs, lib, ... }:

let
  cfg = config.programs.fuzzel;
  format = pkgs.formats.ini { };
in

{
  options.programs.fuzzel = {
    enable = lib.mkEnableOption "Fuzzel Wayland app launcher";
    
    package = lib.mkPackageOption pkgs "fuzzel" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "Fuzzel configuration";
      example = {
        main = {
          font = "JetBrainsMono Nerd Font:size=12";
          prompt = "❯ ";
          colors = {
            background = "282a36ff";
            text = "f8f8f2ff";
            match = "bd93f9ff";
            selection = "44475aff";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."fuzzel/fuzzel.ini".source = lib.mkIf (cfg.settings != { }) (
      format.generate "fuzzel.ini" cfg.settings
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
