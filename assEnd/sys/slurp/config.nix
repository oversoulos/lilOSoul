{ config, pkgs, lib, ... }:

let
  cfg = config.programs.slurp;
in

{
  options.programs.slurp = {
    enable = lib.mkEnableOption "slurp screenshot selector";
    package = lib.mkPackageOption pkgs "slurp" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
