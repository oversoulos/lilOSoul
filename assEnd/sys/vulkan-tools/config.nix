{ config, pkgs, lib, ... }:

let
  cfg = config.programs.vulkan-tools;
in

{
  options.programs.vulkan-tools = {
    enable = lib.mkEnableOption "Vulkan tools (vulkaninfo, vkcube)";
    
    package = lib.mkPackageOption pkgs "vulkan-tools" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
