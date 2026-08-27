{ config, pkgs, lib, ... }:

let
  cfg = config.programs.git;
in

{
  options.programs.git = {
    enable = lib.mkEnableOption "Git version control system";
    
    package = lib.mkPackageOption pkgs "git" { };
    
    userName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Your name for git commits";
      example = "John Doe";
    };
    
    userEmail = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Your email for git commits";
      example = "john@example.com";
    };
    
    signingKey = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "GPG signing key ID";
      example = "ABCD1234";
    };
    
    aliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Git aliases";
      example = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
      };
    };
    
    extraConfig = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Additional git configuration";
      example = {
        core.editor = "nvim";
        init.defaultBranch = "main";
      };
    };

    ignores = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Global gitignore patterns";
      example = [
        ".DS_Store"
        "*.swp"
        "*.pyc"
        "__pycache__/"
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.etc = lib.mkIf (cfg.userName != null || cfg.userEmail != null) {
      "gitconfig".text = ''
        [user]
        ${lib.optionalString (cfg.userName != null) "name = ${cfg.userName}"}
        ${lib.optionalString (cfg.userEmail != null) "email = ${cfg.userEmail}"}
        ${lib.optionalString (cfg.signingKey != null) "signingkey = ${cfg.signingKey}"}
        
        ${lib.optionalString (cfg.aliases != { }) ''
        [alias]
        ${lib.concatStrings (lib.mapAttrsToList (k: v: "  ${k} = ${v}\n") cfg.aliases)}
        ''}
        
        ${lib.concatStrings (lib.mapAttrsToList (k: v: "[${k}]\n  ${v}\n") cfg.extraConfig)}
      '';
    };
    
    environment.etc."gitignore_global".text = lib.mkIf (cfg.ignores != [ ]) ''
      ${builtins.concatStringsSep "\n" cfg.ignores}
    '';
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
