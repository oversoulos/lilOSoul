{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true; # still needed — this installs Hyprland + adds it to PATH
  };

  xdg.configFile."hypr/hyprland.lua".text = ''
    -- OvrOS Hyprland config (native Lua, Hyprland 0.55+)

    -- Monitor: auto-detect, best available resolution, auto position,
    -- 100% scale. This was in the original .conf-style config but got
    -- dropped in the Lua rewrite — added back here. Same honesty flag as
    -- the rest of this file: syntax pattern is best-inference, verify
    -- with `hyprland --verify-config`.
    hl.monitor("", "preferred", "auto", 1)

    hl.config({
      general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
      },
      decoration = {
        rounding = 8,
        active_opacity = 1.0,
        inactive_opacity = 0.95,
      },
      input = {
        kb_layout = "us",
        follow_mouse = 1,
      },
    })

    -- Startup programs
    hl.exec_once("waybar")
    hl.exec_once("nm-applet --indicator")
    hl.exec_once("blueman-applet")
    hl.exec_once("${pkgs.hyprpolkitagent}/bin/hyprpolkitagent")

    -- swww's background daemon — starts ready, but no wallpaper is set yet
    -- since none exist. Once you have an image, set it any time (no
    -- restart needed) with:
    --   swww img /path/to/your/image.png
    hl.exec_once("swww-daemon")

    -- Clipboard history listener — runs quietly in the background,
    -- SUPER+Y opens the searchable history (bound below)
    hl.exec_once("wl-paste --watch cliphist store")

    -- Mission Center + CoreCtrl: launched hidden in their own special
    -- workspace at startup, toggled into view with a hotkey (scratchpad
    -- style — nothing sits on Waybar or your open-window list).
    hl.exec_once("[workspace special:sysmon silent] mission-center")
    hl.exec_once("[workspace special:gpu silent] corectrl")

    -- Keybinds
    -- NOTE: SUPER+M is "exit Hyprland" — kept where it was in the old
    -- config on purpose, did not repurpose it.
    hl.bind({ "SUPER" }, "Return", function() hl.dsp.exec("ghostty") end)
    hl.bind({ "SUPER" }, "Q", function() hl.dsp.killactive() end)
    hl.bind({ "SUPER" }, "E", function() hl.dsp.exec("ghostty -e yazi") end)
    hl.bind({ "SUPER" }, "R", function() hl.dsp.exec("wofi --show drun") end)
    hl.bind({ "SUPER" }, "C", function() hl.dsp.exec("hypr-live-config") end)
    hl.bind({ "SUPER" }, "M", function() hl.dsp.exit() end)
    hl.bind({ "SUPER" }, "V", function() hl.dsp.togglefloating() end)
    hl.bind({ "SUPER" }, "F", function() hl.dsp.fullscreen() end)

    -- Clipboard history picker
    hl.bind({ "SUPER" }, "y", function()
      hl.dsp.exec("cliphist list | wofi --dmenu | cliphist decode | wl-copy")
    end)

    -- Power/session menu (logout, restart, shutdown) without a terminal
    hl.bind({ "SUPER" }, "escape", function()
      hl.dsp.exec("wlogout")
    end)
    hl.bind({ "SUPER", "SHIFT" }, "S", function()
      hl.dsp.exec("grim -g \"$(slurp)\" - | swappy -f -")
    end)

    -- Voice-to-text (nerd-dictation) — hit once to start listening, hit
    -- again to stop. Same key toggles both.
    hl.bind({ "SUPER" }, "space", function()
      hl.dsp.exec("nerd-dictation begin --simulate-input-tool=WTYPE || nerd-dictation end")
    end)

    -- Scratchpad toggles for the system/GPU monitors
    hl.bind({ "SUPER" }, "D", function()
      hl.dsp.togglespecialworkspace("sysmon")
    end)
    hl.bind({ "SUPER", "SHIFT" }, "D", function()
      hl.dsp.togglespecialworkspace("gpu")
    end)
  '';

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps (Vesktop, OBS, etc.) use Wayland
  };
}
