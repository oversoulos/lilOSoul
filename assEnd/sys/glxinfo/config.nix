{ config, pkgs, lib, ... }:

let
  cfg = config.programs.glxinfo;
in

{
  options.programs.glxinfo = {
    enable = lib.mkEnableOption "GLX info tool (OpenGL)";
    
    package = lib.mkPackageOption pkgs "glxinfo" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
