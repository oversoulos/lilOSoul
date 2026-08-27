{ config, pkgs, lib, ... }:

let
  cfg = config.programs.obsidian;
in

{
  options.programs.obsidian = {
    enable = lib.mkEnableOption "Obsidian notes";
    package = lib.mkPackageOption pkgs "obsidian" { };
    vaults = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Obsidian vault paths";
      example = {
        notes = "~/Documents/notes";
        work = "~/Documents/work";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    xdg.dataFile = lib.mkIf (cfg.vaults != { }) (
      builtins.mapAttrs (name: path: {
        target = "obsidian/${name}";
        text = path;
      }) cfg.vaults
    );
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: xdg.desktopEntries
  # overrides, extraConfig files, or app-specific environment vars.
}
