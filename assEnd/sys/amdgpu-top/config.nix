{ config, pkgs, lib, ... }:

let
  cfg = config.programs.amdgpu-top;
in

{
  options.programs.amdgpu-top = {
    enable = lib.mkEnableOption "AMD GPU monitoring tool";
    
    package = lib.mkPackageOption pkgs "amdgpu-top" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
