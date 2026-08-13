{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Add your extensions here
        ms-python.python
        vscodevim.vim
      ];
      userSettings = {
        "editor.fontSize" = 14;
        "workbench.colorTheme" = "Default Dark+";
      };
    };
  };
}