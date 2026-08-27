{ config, pkgs, lib, ... }:

let
  cfg = config.programs.lmstudio;
in

{
  options.programs.lmstudio = {
    enable = lib.mkEnableOption "LM Studio - local LLM GUI";
    package = lib.mkPackageOption pkgs "lmstudio" { };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: a systemd service
  # for always-on operation, or cross-module hooks with the rest
  # of molecular/AI.
}
