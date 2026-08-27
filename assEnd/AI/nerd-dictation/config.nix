{ config, pkgs, lib, ... }:

let
  cfg = config.programs.nerd-dictation;
in

{
  options.programs.nerd-dictation = {
    enable = lib.mkEnableOption "Nerd Dictation - voice-to-text anywhere";
    package = lib.mkPackageOption pkgs "nerd-dictation" { };
    keybind = lib.mkOption {
      type = lib.types.str;
      default = "Alt+Shift+V";
      description = "Keybind to trigger dictation (used by wtype)";
    };
    model = lib.mkOption {
      type = lib.types.str;
      default = "base";
      description = "Whisper model: tiny, base, small, medium, large";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
      pkgs.whisper.cpp
      pkgs.wtype
    ];
    environment.etc."nerd-dictation/config".text = ''
      model=${cfg.model}
      keybind=${cfg.keybind}
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: a systemd service
  # for always-on operation, or cross-module hooks with the rest
  # of molecular/AI.
}
