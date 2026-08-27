{
  imports = [
    ../cli/gh
    ../cli/starship
    ../cli/nano
    ../cli/lazygit
    ../cli/fd
    ../cli/htop
    ../cli/yazi
    ../cli/tmux
    ../cli/eza
    ../cli/btop
    ../cli/bat
    ../cli/zsh
    ../cli/neovim
    ../cli/fuzzel
    ../cli/ripgrep
    ../cli/fastfetch
    ../cli/fzf
    ../cli/git
    ../cli/ghostty
  ];

  # ./tmux now points at a real tmux module (see _notes.md in that folder).
  # The old ./tmux/zoxide path is gone -- zoxide was scrapped per your call,
  # not migrated anywhere else in this category.
}
