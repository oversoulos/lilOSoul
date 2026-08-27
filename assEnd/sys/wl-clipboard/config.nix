{ config, pkgs, lib, ... }:

let
  cfg = config.programs.wl-clipboard;
in

{
  options.programs.wl-clipboard = {
    enable = lib.mkEnableOption "wl-clipboard Wayland clipboard tools";
    package = lib.mkPackageOption pkgs "wl-clipboard" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. matugen/wallust theme handoff).
}
