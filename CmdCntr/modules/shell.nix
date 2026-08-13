{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake .#$(hostname)";
      ovros = "./scripts/deploy-ovros.sh";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
