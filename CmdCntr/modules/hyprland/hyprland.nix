{ pkgs, ... }:
{
  # Writing hyprland.lua directly instead of using home-manager's
  # `settings = { ... }` option. Reason: as of this build, that option has
  # an open, unfixed bug generating correct Lua output (home-manager issue
  # #9468, closed "not planned" by the maintainers) — so it's not something
  # to build on right now. Writing the real file directly is the reliable
  # path.
  wayland.windowManager.hyprland = {
    enable = true; # still needed — this installs Hyprland + adds it to PATH
  };

  # HONESTY FLAG: Hyprland's Lua config shipped in v0.55 (May 2026) and its
  # own docs are still incomplete — even the Hyprland community is actively
  # saying so as of this build. The core pattern below (hl.config, hl.bind,
  # hl.exec_once) is confirmed from the official wiki. A few dispatcher
  # names (hl.dsp.*) are inferred from the old dispatcher names following
  # the same pattern the wiki describes, but aren't individually confirmed.
  #
  # BEFORE trusting this on first boot, run:
  #   hyprland --verify-config
  # If a specific line errors, that's almost always a function name that
  # needs a small tweak — not a sign the whole file is wrong.
  xdg.configFile."hypr/hyprland.lua".text = ''
    -- OvrOS Hyprland config (native Lua, Hyprland 0.55+)

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
    hl.bind({ "SUPER", "SHIFT" }, "S", function()
      hl.dsp.exec("grim -g \"$(slurp)\" - | swappy -f -")
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

Done
Update CmdCntr/modules/hyprland/default.nix (just the imports list):

Ran a command

Ran a command
What actually changed and why, straight:
Went with writing the real hyprland.lua file directly instead of the "let Nix generate it for me" option — that auto-feature has a known, currently-unfixed bug, so building on it would've meant handing you something already shaky.
All your existing keybinds carried over as-is, including SUPER+M staying "exit" like before — nothing quietly changed.
One real limit to know about: since Hyprland's Lua config is only 3 months old, its own documentation is still incomplete — I confirmed the core pattern from the official wiki, but a few of the individual function names (hl.dsp.killactive, hl.dsp.fullscreen, etc.) are my best inference from the old naming, not individually confirmed. That's exactly why the file has a comment at the top telling you to run hyprland --verify-config first — if something errors, it's almost always just one function name needing a tweak, not the whole approach being wrong.
Once you're on the machine and can run --verify-config, bring back whatever error it gives you (if any) and I'll fix that specific line — small correction, not a redo.


Want to be notified when Claude responds?

