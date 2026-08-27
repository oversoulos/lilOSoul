{ config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Enforce strict systemd/UWSM lifecycle tracking
    xwayland.enable = true;
  };

  # ─── MASTER LUA CONFIGURATION PIPELINE ──────────────────────
  # Emits directly to ~/.config/hypr/hyprland.lua for clean execution
  xdg.configFile."hypr/hyprland.lua".text = ''
    -- ovrOS Unified Hyprland Entry Engine (Pure Lua Execution Layout)
    require("lua/monitors")
    require("lua/theme")
    require("lua/keybinds")
    require("lua/drawers")

    -- Background Core Subsystems
    hl.exec_once("nm-applet --indicator")
    hl.exec_once("blueman-applet")
    hl.exec_once("${pkgs.hyprpolkitagent}/bin/hyprpolkitagent")
    hl.exec_once("swww-daemon")
    hl.exec_once("wl-paste --watch cliphist store")

    -- Pre-stage Focal Drawers / Special Scratchpads
    hl.exec_once("[workspace special:dropdown silent] ghostty --class=ghostty-dropterm")
    hl.exec_once("[workspace special:sysmon silent] ghostty --class=ghostty-sysmon -e amdgpu_top")
  '';

  # ─── LUA MONITORS SUB-MODULE ────────────────────────────────
  xdg.configFile."hypr/lua/monitors.lua".text = ''
    -- Layout Topology: DP-1 (I / Main Workspace), HDMI-A-1 (V / Peripheral Monitor)
    hl.monitor("DP-1", "1920x1080@144", "0x0", 1)
    hl.monitor("HDMI-A-1", "1920x1080@60", "1920x0", 1)

    hl.config({
      workspace = {
        "1, monitor:DP-1, default:true",
        "2, monitor:DP-1",
        "3, monitor:HDMI-A-1"
      }
    })
  '';

  # ─── LUA THEMING DESKTOP MATRIX ─────────────────────────────
  xdg.configFile."hypr/lua/theme.lua".text = ''
    -- Visual Core System Parameters
    hl.config({
      general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        ["col.active_border"] = "rgba(bb9af7ff) rgba(7aa2f7ff) 45deg",
        ["col.inactive_border"] = "rgba(1a1b26ff)"
      },
      decoration = {
        rounding = 0, -- Hard Sharp Edges (Structural BSG Matrix Style)
        active_opacity = 0.98,
        inactive_opacity = 0.88,
        shadow = {
          enabled = true,
          range = 20,
          render_power = 4,
          color = "rgba(000000aa)"
        },
        blur = {
          enable = true,
          size = 6,
          passes = 3
        }
      }
    })
  '';

  # ─── LUA KEYBINDINGS DISPATCH ENGINE ────────────────────────
  xdg.configFile."hypr/lua/keybinds.lua".text = ''
    -- Interface Direct Bind Execution Logic
    hl.bind({ "SUPER" }, "Return", function() hl.dsp.exec("ghostty") end)
    hl.bind({ "SUPER" }, "Q", function() hl.dsp.killactive() end)
    hl.bind({ "SUPER" }, "E", function() hl.dsp.exec("ghostty -e yazi") end)
    hl.bind({ "SUPER" }, "C", function() hl.dsp.exec("hypr-live-config") end)
    hl.bind({ "SUPER" }, "M", function() hl.dsp.exit() end)
    hl.bind({ "SUPER" }, "V", function() hl.dsp.togglefloating() end)
    hl.bind({ "SUPER" }, "F", function() hl.dsp.fullscreen() end)

    -- Universal Omni Search Engine (SUPER + Space)
    hl.bind({ "SUPER" }, "Space", function()
      hl.dsp.exec("wofi --show drun --prompt 'Search Apps, Notes & Files...' --location bottom --yoffset -20")
    end)

    -- Dropdown Terminal Focus Hook (SUPER + `)
    hl.bind({ "SUPER" }, "grave", function()
      hl.dsp.togglespecialworkspace("dropdown")
    end)

    -- System Performance Drawer Hook (SUPER + D)
    hl.bind({ "SUPER" }, "D", function()
      hl.dsp.togglespecialworkspace("sysmon")
    end)

    -- Secure History Clipboard Layer (SUPER + Y)
    hl.bind({ "SUPER" }, "Y", function()
      hl.dsp.exec("cliphist list | wofi --dmenu | cliphist decode | wl-copy")
    end)

    -- Real-time Dictation Interface Management (F5 Architecture)
    hl.bind({}, "F5", function()
      hl.dsp.exec("nerd-dictation begin --vosk-model-dir=~/.config/nerd-dictation/model")
    end)
    hl.bind({ "SHIFT" }, "F5", function()
      hl.dsp.exec("nerd-dictation end")
    end)
  '';

  # ─── LUA WINDOW SCRATCHPAD RULES ────────────────────────────
  xdg.configFile."hypr/lua/drawers.lua".text = ''
    -- System Layout Constraints for Dynamic Overlay Containers
    hl.windowrule({
      "float, class:^(ghostty-dropterm)$",
      "workspace special:dropdown silent, class:^(ghostty-dropterm)$",
      "size 85% 50%, class:^(ghostty-dropterm)$",
      "move 7.5% 4%, class:^(ghostty-dropterm)$",

      "float, class:^(ghostty-sysmon)$",
      "workspace special:sysmon silent, class:^(ghostty-sysmon)$",
      "size 80% 60%, class:^(ghostty-sysmon)$",
      "move 10% 20%, class:^(ghostty-sysmon)$"
    })
  '';
}
