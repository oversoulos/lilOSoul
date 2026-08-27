{ config, pkgs, lib, ... }:

let
  cfg = config.programs.huggingface;
in

{
  options.programs.huggingface = {
    enable = lib.mkEnableOption "Hugging Face CLI tools";
    package = lib.mkPackageOption pkgs "huggingface-hub" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: a systemd service
  # for always-on operation, or cross-module hooks with the rest
  # of molecular/AI.
}
