{ config, pkgs, lib, ... }:

let
  cfg = config.programs.obs-studio;
in

{
  options.programs.obs-studio = {
    enable = lib.mkEnableOption "OBS Studio recording/streaming";
    package = lib.mkPackageOption pkgs "obs-studio" { };
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "OBS plugins";
    };
    enableVirtualCamera = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable virtual camera (v4l2loopback)";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.wrapOBS.override { obs-studio = cfg.package; } { plugins = cfg.plugins; })
    ];
    boot = lib.mkIf cfg.enableVirtualCamera {
      kernelModules = [ "v4l2loopback" ];
      extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    };
    security.polkit.enable = lib.mkIf cfg.enableVirtualCamera true;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
