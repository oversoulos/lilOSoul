{ config, pkgs, lib, ... }:

let
  cfg = config.programs.koboldcpp;
in

{
  options.programs.koboldcpp = {
    enable = lib.mkEnableOption "KoboldCPP local LLM with GUI";
    package = lib.mkPackageOption pkgs "koboldcpp" { };
    useVulkan = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Vulkan support for AMD GPUs";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (cfg.package.override { inherit (cfg) useVulkan; })
    ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: a systemd service
  # for always-on operation, or cross-module hooks with the rest
  # of molecular/AI.
}
