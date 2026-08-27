{ config, pkgs, lib, ... }:

let
  cfg = config.programs.fd;
in

{
  options.programs.fd = {
    enable = lib.mkEnableOption "fd simple file finder";
    
    package = lib.mkPackageOption pkgs "fd" { };
    
    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Shell aliases for fd";
      example = {
        f = "fd";
        ff = "fd --type f";
        fd = "fd --hidden";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.shellAliases = cfg.aliases;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
