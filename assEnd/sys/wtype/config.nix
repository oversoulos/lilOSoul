{ config, pkgs, lib, ... }:

let
  cfg = config.programs.wtype;
in

{
  options.programs.wtype = {
    enable = lib.mkEnableOption "wtype - Wayland text typing tool";
    package = lib.mkPackageOption pkgs "wtype" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
