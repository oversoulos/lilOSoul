{ config, pkgs, lib, ... }:

let
  cfg = config.programs.neovim;
in

{
  options.programs.neovim = {
    enable = lib.mkEnableOption "Neovim text editor";
    
    package = lib.mkPackageOption pkgs "neovim" { };
    
    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Set as default editor";
    };
    
    viAlias = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create vi alias";
    };
    
    vimAlias = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Create vim alias";
    };
    
    withPython3 = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Python 3 provider";
    };
    
    withNodeJs = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Node.js provider";
    };
    
    withRuby = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Ruby provider";
    };
    
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        gopls
        lua-language-server
        nil
        nixfmt
        ripgrep
        fd
        tree-sitter
      ];
      description = "Extra packages for Neovim (LSPs, formatters)";
    };
    
    initLua = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "init.lua content";
      example = ''
        vim.g.mapleader = " "
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        
        -- Keymaps
        vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
        vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
      '';
    };
    
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs.vimPlugins; [
        nvim-tree-lua
        telescope-nvim
        nvim-lspconfig
        blink-cmp
        lualine-nvim
        dracula-nvim
      ];
      description = "Neovim plugins";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.wrapNeovim cfg.package {
        viAlias = cfg.viAlias;
        vimAlias = cfg.vimAlias;
        withPython3 = cfg.withPython3;
        withNodeJs = cfg.withNodeJs;
        withRuby = cfg.withRuby;
        extraPackages = cfg.extraPackages;
        configure = {
          customRC = "";
          customLuaRC = cfg.initLua;
          packages.myVimPackage = {
            start = cfg.plugins;
            opt = [ ];
          };
        };
      })
    ];
    
    environment.sessionVariables.EDITOR = lib.mkIf cfg.defaultEditor "nvim";
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. Likely candidates: extraConfig passthrough,
  # or cross-module hooks (e.g. theme colors from matugen/wallust).
}
