{ pkgs, ... }:
{
  # "Maxed" here means: solid, declarative day-one defaults, with vim as
  # your notepad covered. LazyVim / a plugin ecosystem is intentionally NOT
  # wired in yet — that's next-phase scope (theming/tooling pass), same as
  # Hyprland's own theming. Adding LazyVim later means pointing this at a
  # starter config or building extraConfig/plugins here once you're in and
  # ready.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set number relativenumber
      set clipboard=unnamedplus
      set ignorecase
      set smartcase
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set termguicolors
      set mouse=a
      set undofile
    '';
  };
}
