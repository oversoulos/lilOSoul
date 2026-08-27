
 { config, pkgs, lib, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    # ============================================================
    # 🔥 ALL PLUGINS ACTIVATED — EVERY SINGLE ONE
    # ============================================================
    plugins = [
      "hy3"                    # i3-like manual tiling
      "hyprspace"              # workspace overview (SUPER+Tab)
      "hyprsplit"              # awesome/dwm-like workspaces
      "hyprgrass"              # touch gestures
      "hypr-dynamic-cursors"   # realistic cursor physics
      "imgborders"             # tiling image borders
      "hypr-darkwindow"        # invert colors on windows
      "borders-plus-plus"      # multiple borders
      "hyprbars"               # window title bars
      "hyprfocus"              # flashfocus effect
    ];
  };

  # ─── MASTER LUA CONFIGURATION — ABSOLUTELY MAXED ────────────
  xdg.configFile."hypr/hyprland.lua".text = ''
    -- ovrOS: MAXIMUM OVERDRIVE EDITION
    require("lua/monitors")
    require("lua/theme")
    require("lua/keybinds")
    require("lua/drawers")

    -- Background services — all of them
    hl.exec_once("nm-applet --indicator")
    hl.exec_once("blueman-applet")
    hl.exec_once("${pkgs.hyprpolkitagent}/bin/hyprpolkitagent")
    hl.exec_once("swww-daemon")
    hl.exec_once("wl-paste --watch cliphist store")
    hl.exec_once("dms")  -- DMS shell
    hl.exec_once("waybar")  -- backup bar just in case

    -- Scratchpads pre-loaded
    hl.exec_once("[workspace special:dropdown silent] ghostty --class=ghostty-dropterm")
    hl.exec_once("[workspace special:sysmon silent] ghostty --class=ghostty-sysmon -e amdgpu_top")
    hl.exec_once("[workspace special:music silent] spotify")
    hl.exec_once("[workspace special:notes silent] obsidian")
  '';

  # ─── MONITORS: DUAL SCREEN MAX LAYOUT ────────────────────────
  xdg.configFile."hypr/lua/monitors.lua".text = ''
    hl.monitor("DP-1", "1920x1080@144", "0x0", 1)
    hl.monitor("HDMI-A-1", "1920x1080@60", "1920x0", 1)

    hl.config({
      workspace = {
        "1, monitor:DP-1, default:true",
        "2, monitor:DP-1",
        "3, monitor:DP-1",
        "4, monitor:HDMI-A-1",
        "5, monitor:HDMI-A-1",
        "6, monitor:HDMI-A-1",
        "7, monitor:HDMI-A-1",
        "special:dropdown, monitor:DP-1",
        "special:sysmon, monitor:DP-1",
        "special:music, monitor:HDMI-A-1",
        "special:notes, monitor:HDMI-A-1"
      }
    })
  '';

  # ─── THEME: FULL BLOWN VISUAL ORGASM ─────────────────────────
  xdg.configFile."hypr/lua/theme.lua".text = ''
    hl.config({
      general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 3,
        ["col.active_border"] = "rgba(bb9af7ff) rgba(7aa2f7ff) rgba(ff79c6ff) 45deg",
        ["col.inactive_border"] = "rgba(1a1b26ff)",
        cursor_inactive_timeout = 3,
        layout = "dwindle",
        no_border_on_floating = false,
        resize_on_border = true,
        extend_border_grab_area = 15,
        hover_icon_on_border = true,
      },
      decoration = {
        rounding = 4,
        active_opacity = 1.0,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1.0,
        shadow = {
          enabled = true,
          range = 30,
          render_power = 5,
          color = "rgba(000000dd)",
          offset = "0 4",
        },
        blur = {
          enable = true,
          size = 8,
          passes = 4,
          new_optimizations = true,
          noise = 0.01,
          contrast = 1.0,
          brightness = 1.0,
          vibrancy = 0.2,
          vibrancy_darkness = 0.5,
          special = true,
          popups = true,
          popups_ignorealpha = 0.1,
          xray = true,
        },
        dim_inactive = true,
        dim_strength = 0.3,
        screen_shader = "",
      },
      animations = {
        enabled = true,
        bezier = {
          "overshot, 0.13, 0.99, 0.29, 1.1",
          "smoothOut, 0.36, 0, 0.66, -0.56",
          "smoothIn, 0.25, 1, 0.5, 1",
          "wind, 0, 0.55, 0.45, 1",
        },
        animation = {
          "windows, 1, 4, overshot, popin",
          "windowsIn, 1, 4, overshot, popin",
          "windowsOut, 1, 4, smoothOut, popin",
          "border, 1, 6, default",
          "borderangle, 1, 8, default",
          "fade, 1, 6, default",
          "workspaces, 1, 5, smoothOut, slidevert",
          "workspacesIn, 1, 5, smoothOut, slidevert",
          "workspacesOut, 1, 5, smoothOut, slidevert",
          "specialWorkspace, 1, 5, smoothOut, slidevert",
        },
      },
      dwindle = {
        pseudotile = true,
        preserve_split = true,
        force_split = 2,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
      },
      master = {
        new_is_master = true,
        new_on_top = true,
        no_gaps_when_only = false,
        orientation = "center",
        allow_small_split = true,
        smart_resizing = true,
        special_scale_factor = 0.8,
      },
      gestures = {
        workspace_swipe = true,
        workspace_swipe_fingers = 3,
        workspace_swipe_distance = 300,
        workspace_swipe_invert = false,
        workspace_swipe_min_speed_to_force = 30,
        workspace_swipe_cancel_ratio = 0.5,
        workspace_swipe_create_new = true,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_use_r = true,
      },
      misc = {
        disable_autoreload = false,
        disable_hyprland_logo = false,
        force_default_wallpaper = 0,
        vfr = true,
        vfr_wh = 0,
        mouse_move_enables_dpms = false,
        key_press_enables_dpms = false,
        always_follow_on_dnd = true,
        layers_hog_keyboard_focus = true,
        animate_manual_resizes = true,
        animate_mouse_windowdragging = false,
        disable_autoreload = false,
        enable_swallow = true,
        swallow_regex = "^(Alacritty|foot|ghostty)$",
        focus_on_activate = true,
        mouse_move_focuses_monitor = true,
        render_ahead_of_time = true,
        render_ahead_safezone = 10,
        allow_session_lock_restore = true,
        background_color = "0x11111b",
        close_special_on_empty = true,
        new_window_takes_over_fullscreen = 2,
        no_direct_scanout = false,
        cursor_zoom_factor = 1.0,
        cursor_zoom_rigid = false,
        cursor_zoom_warps = true,
        cursor_zoom_restore_time = 1.0,
        cursor_zoom_restore_speed = 5.0,
        cursor_zoom_curve = "0.4, 0.8",
        refresh_rate = 0,
        no_vfr = false,
        suppress_portal_warnings = false,
        tablet_vrr = true,
        intel_pstate = false,
        no_direct_scanout = false,
        nebula_ignore_alpha = 1.0,
        nebula_opacity = 0.9,
        nebula_color = "0x000000",
        nebula_radius = 0.4,
        nebula_brightness = 1.0,
        nebula_contrast = 1.0,
        nebula_center_x = 0.5,
        nebula_center_y = 0.5,
      },
      xwayland = {
        force_zero_scaling = true,
        use_nearest_neighbor = false,
      },
      opengl = {
        nvidia_anti_flicker = false,
        nvidia_anti_flicker_workaround = false,
        no_gl_fb_flush = false,
        force_introspection = false,
      },
      render = {
        direct_scanout = true,
        explicit_sync = true,
        explicit_sync_kms = true,
        mouse = true,
        drm_backend = true,
        damage_blend = true,
        damage_tracking = true,
      },
    })
  '';

  # ─── KEYBINDS: EVERYTHING AND THE KITCHEN SINK ──────────────
  xdg.configFile."hypr/lua/keybinds.lua".text = ''
    -- SUPER layer
    hl.bind({ "SUPER" }, "Return", function() hl.dsp.exec("ghostty") end)
    hl.bind({ "SUPER" }, "Q", function() hl.dsp.killactive() end)
    hl.bind({ "SUPER" }, "E", function() hl.dsp.exec("ghostty -e yazi") end)
    hl.bind({ "SUPER" }, "R", function() hl.dsp.exec("wofi --show drun") end)
    hl.bind({ "SUPER" }, "C", function() hl.dsp.exec("hypr-live-config") end)
    hl.bind({ "SUPER" }, "M", function() hl.dsp.exit() end)
    hl.bind({ "SUPER" }, "V", function() hl.dsp.togglefloating() end)
    hl.bind({ "SUPER" }, "F", function() hl.dsp.fullscreen() end)
    hl.bind({ "SUPER" }, "P", function() hl.dsp.pseudo() end)
    hl.bind({ "SUPER" }, "S", function() hl.dsp.togglesplit() end)
    hl.bind({ "SUPER" }, "T", function() hl.dsp.togglegroup() end)

    -- Window movement
    hl.bind({ "SUPER" }, "h", function() hl.dsp.movefocus("l") end)
    hl.bind({ "SUPER" }, "l", function() hl.dsp.movefocus("r") end)
    hl.bind({ "SUPER" }, "k", function() hl.dsp.movefocus("u") end)
    hl.bind({ "SUPER" }, "j", function() hl.dsp.movefocus("d") end)

    hl.bind({ "SUPER SHIFT" }, "h", function() hl.dsp.movewindow("l") end)
    hl.bind({ "SUPER SHIFT" }, "l", function() hl.dsp.movewindow("r") end)
    hl.bind({ "SUPER SHIFT" }, "k", function() hl.dsp.movewindow("u") end)
    hl.bind({ "SUPER SHIFT" }, "j", function() hl.dsp.movewindow("d") end)

    -- Resize
    hl.bind({ "SUPER CTRL" }, "h", function() hl.dsp.resizeactive("-20 0") end)
    hl.bind({ "SUPER CTRL" }, "l", function() hl.dsp.resizeactive("20 0") end)
    hl.bind({ "SUPER CTRL" }, "k", function() hl.dsp.resizeactive("0 -20") end)
    hl.bind({ "SUPER CTRL" }, "j", function() hl.dsp.resizeactive("0 20") end)

    -- Workspaces
    for i = 1, 9 do
      hl.bind({ "SUPER" }, tostring(i), function() hl.dsp.workspace(tostring(i)) end)
      hl.bind({ "SUPER SHIFT" }, tostring(i), function() hl.dsp.movetoworkspace(tostring(i)) end)
    end

    -- Special workspaces
    hl.bind({ "SUPER" }, "grave", function() hl.dsp.togglespecialworkspace("dropdown") end)
    hl.bind({ "SUPER" }, "D", function() hl.dsp.togglespecialworkspace("sysmon") end)
    hl.bind({ "SUPER" }, "M", function() hl.dsp.togglespecialworkspace("music") end)
    hl.bind({ "SUPER" }, "N", function() hl.dsp.togglespecialworkspace("notes") end)

    -- OMNI-SEARCH (SUPER + Space)
    hl.bind({ "SUPER" }, "Space", function()
      hl.dsp.exec("wofi --show drun --prompt '🚀 Search Apps, Notes & Files...' --location bottom --yoffset -20")
    end)

    -- Clipboard Manager (SUPER + Y)
    hl.bind({ "SUPER" }, "Y", function()
      hl.dsp.exec("cliphist list | wofi --dmenu | cliphist decode | wl-copy")
    end)

    -- Emoji Picker (SUPER + .)
    hl.bind({ "SUPER" }, "period", function()
      hl.dsp.exec("bemoji -t")
    end)

    -- Wallpaper Gallery (SUPER + W)
    hl.bind({ "SUPER" }, "W", function()
      hl.dsp.exec("waypaper")
    end)

    -- Screenshot (SUPER + Shift + S)
    hl.bind({ "SUPER SHIFT" }, "S", function()
      hl.dsp.exec("grim -g \"$(slurp)\" - | wl-copy")
    end)

    -- Screenshot with annotation (SUPER + Shift + A)
    hl.bind({ "SUPER SHIFT" }, "A", function()
      hl.dsp.exec("grim -g \"$(slurp)\" - | swappy -f -")
    end)

    -- Full screenshot (SUPER + Shift + F)
    hl.bind({ "SUPER SHIFT" }, "F", function()
      hl.dsp.exec("grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png")
    end)

    -- Voice Dictation (F5)
    hl.bind({}, "F5", function()
      hl.dsp.exec("nerd-dictation begin --vosk-model-dir=~/.config/nerd-dictation/model")
    end)
    hl.bind({ "SHIFT" }, "F5", function()
      hl.dsp.exec("nerd-dictation end")
    end)

    -- Media controls
    hl.bind({}, "XF86AudioRaiseVolume", function() hl.dsp.exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+") end)
    hl.bind({}, "XF86AudioLowerVolume", function() hl.dsp.exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end)
    hl.bind({}, "XF86AudioMute", function() hl.dsp.exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end)
    hl.bind({}, "XF86AudioPlay", function() hl.dsp.exec("playerctl play-pause") end)
    hl.bind({}, "XF86AudioNext", function() hl.dsp.exec("playerctl next") end)
    hl.bind({}, "XF86AudioPrev", function() hl.dsp.exec("playerctl previous") end)

    -- Brightness
    hl.bind({}, "XF86MonBrightnessUp", function() hl.dsp.exec("brightnessctl s +5%") end)
    hl.bind({}, "XF86MonBrightnessDown", function() hl.dsp.exec("brightnessctl s 5%-") end)

    -- Submap for quick resize
    hl.bind({ "SUPER" }, "r", function()
      hl.dsp.submap("resize")
    end)
    hl.bind({}, "Escape", function()
      hl.dsp.submap("reset")
    end)
  '';

  # ─── SCRATCHPADS: MAXIMUM OVERDRIVE ──────────────────────────
  xdg.configFile."hypr/lua/drawers.lua".text = ''
    hl.windowrule({
      -- Dropdown terminal
      "float, class:^(ghostty-dropterm)$",
      "workspace special:dropdown silent, class:^(ghostty-dropterm)$",
      "size 85% 50%, class:^(ghostty-dropterm)$",
      "move 7.5% 4%, class:^(ghostty-dropterm)$",

      -- System monitor
      "float, class:^(ghostty-sysmon)$",
      "workspace special:sysmon silent, class:^(ghostty-sysmon)$",
      "size 80% 60%, class:^(ghostty-sysmon)$",
      "move 10% 20%, class:^(ghostty-sysmon)$",

      -- Music player
      "float, class:^(spotify)$",
      "workspace special:music silent, class:^(spotify)$",
      "size 70% 80%, class:^(spotify)$",
      "move 15% 10%, class:^(spotify)$",

      -- Obsidian notes
      "float, class:^(obsidian)$",
      "workspace special:notes silent, class:^(obsidian)$",
      "size 75% 85%, class:^(obsidian)$",
      "move 12.5% 7.5%, class:^(obsidian)$",

      -- Floating rules for dialogs
      "float, class:^(pavucontrol)$",
      "float, class:^(blueman-manager)$",
      "float, class:^(nm-connection-editor)$",
      "float, class:^(nwg-look)$",
      "float, class:^(wdisplays)$",
      "float, class:^(waypaper)$",
      "float, class:^(gnome-calculator)$",

      -- Center all floating windows
      "center, class:^(pavucontrol)$",
      "center, class:^(blueman-manager)$",
      "center, class:^(nm-connection-editor)$",
      "center, class:^(nwg-look)$",
      "center, class:^(wdisplays)$",
      "center, class:^(waypaper)$",
      "center, class:^(gnome-calculator)$",
    })

    -- Window rules for specific apps
    hl.windowrulev2({
      "opacity 1.0 override 0.9 override, class:^(foot)$",
      "opacity 1.0 override 0.9 override, class:^(ghostty)$",
      "nofocus, class:^(nm-applet)$",
      "nofocus, class:^(blueman-applet)$",
      "nofocus, class:^(hyprpolkitagent)$",
      "nofocus, class:^(swww-daemon)$",
      "nofocus, class:^(wl-paste)$",
    })
  '';
}
