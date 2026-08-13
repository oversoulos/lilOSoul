{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    bat
    fzf
    tree
    p7zip
    lazygit
  ];
}
