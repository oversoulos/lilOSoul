{ ... }:
{
  # Syntax fixed (values now properly quoted strings). Name/email left
  # blank on purpose since neither was given — fill these in whenever, or
  # leave blank and git will still work locally, it just won't attach an
  # identity to commits until this is set.
  programs.git = {
    enable = true;
    userName = "oversoulos"; 
    userEmail = "sooversoulo@gmail.com"; 
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
