{ pkgs, ... }:
let
  hyprLiveConfig = pkgs.writeShellScriptBin "hypr-live-config" ''
    set -eu

    menu_entry="$(printf '%s\n' \
      'Balanced (default)' \
      'Compact (more windows)' \
      'Presentation (single focus)' \
      'Open Theme UI (nwg-look)' \
      'Open Display UI (wdisplays)' | wofi --dmenu --prompt 'Hyprland live config')"

    case "$menu_entry" in
      "Balanced (default)")
        lua "$HOME/.config/hypr/lua/live-config.lua" balanced
        ;;
      "Compact (more windows)")
        lua "$HOME/.config/hypr/lua/live-config.lua" compact
        ;;
      "Presentation (single focus)")
        lua "$HOME/.config/hypr/lua/live-config.lua" presentation
        ;;
      "Open Theme UI (nwg-look)")
        exec nwg-look
        ;;
      "Open Display UI (wdisplays)")
        exec wdisplays
        ;;
      *)
        exit 0
        ;;
    esac
  '';
in
{
  home.packages = [ hyprLiveConfig pkgs.lua ];

  xdg.configFile."hypr/lua/live-config.lua".text = ''
    local preset = arg[1]

    local function run(command)
      os.execute(command)
    end

    if preset == "balanced" then
      run("hyprctl keyword general:gaps_in 4")
      run("hyprctl keyword general:gaps_out 8")
      run("hyprctl keyword general:border_size 2")
      run("hyprctl keyword decoration:rounding 8")
    elseif preset == "compact" then
      run("hyprctl keyword general:gaps_in 1")
      run("hyprctl keyword general:gaps_out 2")
      run("hyprctl keyword general:border_size 1")
      run("hyprctl keyword decoration:rounding 2")
    elseif preset == "presentation" then
      run("hyprctl keyword general:gaps_in 12")
      run("hyprctl keyword general:gaps_out 18")
      run("hyprctl keyword general:border_size 3")
      run("hyprctl keyword decoration:rounding 14")
    end
  '';
}
