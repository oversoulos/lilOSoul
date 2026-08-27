{ config, pkgs, lib, ... }:

let
  cfg = config.programs.whispercpp;
in

{
  options.programs.whispercpp = {
    enable = lib.mkEnableOption "Whisper.cpp voice-to-text";
    package = lib.mkPackageOption pkgs "whisper.cpp" { };
    useVulkan = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Vulkan support for AMD GPUs";
    };
    model = lib.mkOption {
      type = lib.types.str;
      default = "base";
      description = "Whisper model: tiny, base, small, medium, large";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (cfg.package.override { inherit (cfg) useVulkan; })
    ];
    environment.etc."whisper/models".text = cfg.model;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: a systemd service
  # for always-on operation, or cross-module hooks with the rest
  # of molecular/AI.
}
