{ config, pkgs, lib, ... }:

let
  cfg = config.programs.insomnia;
in

{
  options.programs.insomnia = {
    enable = lib.mkEnableOption "Insomnia REST/GraphQL API client";
    package = lib.mkPackageOption pkgs "insomnia" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: pre-seeding a request
  # collection file, or environment vars for a local dev API base URL.
}
