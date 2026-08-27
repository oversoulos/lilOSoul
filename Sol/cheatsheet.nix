## this needs to be truned into an extensive library of books, as discribed in pipedreams.txt, clearly labeled and organized in an directory, and keybound, or cmd line called globally, or searched in the theoretical 3n1 search bar widget***

{ pkgs, ... }:
let
  cheatsheetScript = pkgs.writeShellScriptBin "show-cheatsheet" ''
    #!/usr/bin/env bash

    INDEX_DIR="$HOME/Documents/lilOSoul/cheats"
    mkdir -p "$INDEX_DIR"

    # 1. Grab live Hyprland Keybinds straight from memory
    HYPR_BINDS=$(hyprctl binds -j 2>/dev/null | ${pkgs.jq}/bin/jq -r '.[] | "[\(.modmask)] \(.key) -> \(.dispatcher): \(.arg)"' 2>/dev/null || echo "")

    # 2. Read any custom markdown/text cheatsheets in the cheat directory
    CUSTOM_CHEATS=""
    if [ -d "$INDEX_DIR" ]; then
      CUSTOM_CHEATS=$(cat "$INDEX_DIR"/* 2>/dev/null || echo "")
    fi

    # 3. Merge everything dynamically and present in Wofi
    COMBINED=$(printf "%s\n%s" "$HYPR_BINDS" "$CUSTOM_CHEATS" | grep -v '^[[:space:]]*$')

    SELECTED=$(echo "$COMBINED" | wofi --dmenu --prompt "📖 Auto-Indexed Command Encyclopedia" --width 800 --height 600)

    # Copy selected string to system clipboard
    if [ -n "$SELECTED" ]; then
      echo "$SELECTED" | wl-copy
    fi
  '';
in
{
  home.packages = [ cheatsheetScript ];
}
