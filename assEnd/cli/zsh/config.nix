{ config, pkgs, lib, ... }:

let
  cfg = config.programs.zsh;
in

{
  options.programs.zsh = {
    enable = lib.mkEnableOption "Z shell";
    
    package = lib.mkPackageOption pkgs "zsh" { };
    
    prompt = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Custom prompt (disables starship if enabled)";
    };
    
    enableCompletion = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable completion";
    };
    
    enableAutosuggestions = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable autosuggestions";
    };
    
    enableSyntaxHighlighting = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable syntax highlighting";
    };
    
    ohMyZsh = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Oh My Zsh framework";
      };
      
      plugins = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "git" "sudo" "systemd" ];
        description = "Oh My Zsh plugins";
      };
      
      theme = lib.mkOption {
        type = lib.types.str;
        default = "robbyrussell";
        description = "Oh My Zsh theme";
      };
      
      customPkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Custom Oh My Zsh packages";
      };
    };
    
    history = {
      size = lib.mkOption {
        type = lib.types.int;
        default = 10000;
        description = "History size";
      };
      
      file = lib.mkOption {
        type = lib.types.str;
        default = "$HOME/.zsh_history";
        description = "History file location";
      };
      
      share = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Share history across sessions";
      };
      
      ignoreDups = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Ignore duplicate entries";
      };
      
      extended = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Extended history (timestamps)";
      };
    };
    
    setOptions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "HIST_IGNORE_DUPS"
        "SHARE_HISTORY"
        "HIST_FCNTL_LOCK"
        "AUTO_CD"
        "AUTO_PUSHD"
        "PUSHD_IGNORE_DUPS"
        "INTERACTIVE_COMMENTS"
        "NO_BEEP"
        "HIST_VERIFY"
        "EXTENDED_HISTORY"
      ];
      description = "Zsh options";
    };
    
    shellAliases = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        ll = "ls -la";
        l = "ls -l";
        la = "ls -a";
        .. = "cd ..";
        ... = "cd ../..";
        .... = "cd ../../..";
        g = "git";
        grep = "grep --color=auto";
        diff = "diff --color=auto";
      };
      description = "Shell aliases";
    };
    
    loginShellInit = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Login shell init code";
    };
    
    interactiveShellInit = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Interactive shell init code";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    
    environment.shells = [ cfg.package ];
    
    programs.zsh = {
      enableCompletion = cfg.enableCompletion;
      
      autosuggestion = {
        enable = cfg.enableAutosuggestions;
        highlightStyle = "fg=8";
      };
      
      syntaxHighlighting = {
        enable = cfg.enableSyntaxHighlighting;
        highlighters = [ "main" "brackets" "pattern" "cursor" ];
        patterns = {
          "rm -rf *" = "fg=white,bold,bg=red";
        };
        styles = {
          alias = "fg=magenta,bold";
          command = "fg=green";
          hashed-command = "fg=green";
          builtin = "fg=cyan,bold";
          function = "fg=cyan,bold";
          suffix-alias = "fg=magenta";
          directory = "fg=blue,bold";
        };
      };
      
      history = {
        size = cfg.history.size;
        path = cfg.history.file;
        share = cfg.history.share;
        ignoreDups = cfg.history.ignoreDups;
        extended = cfg.history.extended;
      };
      
      setOptions = cfg.setOptions;
      shellAliases = cfg.shellAliases;
      loginShellInit = cfg.loginShellInit;
      interactiveShellInit = cfg.interactiveShellInit;
    };
    
    programs.zsh.ohMyZsh = lib.mkIf cfg.ohMyZsh.enable {
      enable = true;
      plugins = cfg.ohMyZsh.plugins;
      theme = cfg.ohMyZsh.theme;
      customPkgs = cfg.ohMyZsh.customPkgs;
    };
    
    programs.zsh.promptInit = lib.mkIf (cfg.prompt != "") cfg.prompt;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
