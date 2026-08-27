{ config, pkgs, lib, ... }:

let
  cfg = config.programs.nano;
in

{
  options.programs.nano = {
    enable = lib.mkEnableOption "Nano text editor (backup editor)";
    
    package = lib.mkPackageOption pkgs "nano" { };
    
    settings = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "nano configuration";
      example = ''
        set tabsize 4
        set linenumbers
        set mouse
        set autoindent
        set whitespace 0
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."nanorc".text = lib.mkIf (cfg.settings != "") cfg.settings;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
