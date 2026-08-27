{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
  };

  # Direct Hyprland configuration string
  xdg.configFile."hypr/hyprland.lua".text = ''
    require("lua/monitors")
    require("lua/theme")
    require("lua/keybinds")
    require("lua/drawers")

    hl.exec_once("waybar")
    hl.exec_once("nm-applet --indicator")
    hl.exec_once("blueman-applet")
    hl.exec_once("${pkgs.hyprpolkitagent}/bin/hyprpolkitagent")
    hl.exec_once("swww-daemon")
    hl.exec_once("wl-paste --watch cliphist store")

    -- Pre-spawn background scratchpad instances
    hl.exec_once("[workspace special:dropdown silent] ghostty --class=ghostty-dropterm")
    hl.exec_once("[workspace special:sysmon silent] ghostty --class=ghostty-sysmon -e amdgpu_top")
  '';

  xdg.configFile."hypr/lua/monitors.lua".text = builtins.readFile ./envLua/monitors.lua;
  xdg.configFile."hypr/lua/theme.lua".text = builtins.readFile ./envLua/theme.lua;
  xdg.configFile."hypr/lua/keybinds.lua".text = builtins.readFile ./envLua/keybinds.lua;
  xdg.configFile."hypr/lua/drawers.lua".text = builtins.readFile ./envLua/drawers.lua;


  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
