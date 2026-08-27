{ config, pkgs, lib, ... }:

let
  cfg = config.programs.gh;
  format = pkgs.formats.yaml { };
in

{
  options.programs.gh = {
    enable = lib.mkEnableOption "GitHub CLI tool";
    
    package = lib.mkPackageOption pkgs "gh" { };
    
    settings = lib.mkOption {
      type = format.type;
      default = { };
      description = "gh configuration (hosts.yml)";
      example = {
        github.com = {
          user = "username";
          git_protocol = "ssh";
        };
      };
    };
    
    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "gh aliases";
      example = {
        co = "pr checkout";
        prs = "pr list";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc."gh/hosts.yml".source = lib.mkIf (cfg.settings != { }) (
      format.generate "gh-hosts.yml" cfg.settings
    );
    
    environment.etc."gh/config.yml".text = lib.mkIf (cfg.aliases != { }) ''
      version: 1
      aliases:
        ${lib.concatStrings (lib.mapAttrsToList (k: v: "  ${k}: ${v}\n") cfg.aliases)}
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
