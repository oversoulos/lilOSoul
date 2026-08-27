
let
  cfg = config.programs.hyprland;
in

{
  options.programs.hyprland = {

    # ─── MAIN SWITCH ──────────────────────────────────────────
    enable = lib.mkEnableOption "Hyprland Wayland compositor";

    # ─── PACKAGE ──────────────────────────────────────────────
    package = lib.mkPackageOption pkgs "hyprland" { };
    
    # ─── UWSM INTEGRATION ────────────────────────────────────
    withUWSM = lib.mkEnableOption "UWSM session management" // { default = true; };

    # ─── XWAYLAND ─────────────────────────────────────────────
    xwayland = {
      enable = lib.mkEnableOption "Xwayland support" // { default = true; };
      package = lib.mkPackageOption pkgs "xwayland" { };
    };

    # ─── PLUGINS ──────────────────────────────────────────────
    plugins = lib.mkOption {
      type = lib.types.listOf (lib.types.either lib.types.package lib.types.path);
      default = [ ];
      description = ''
        List of Hyprland plugins to load.
        Available plugins: hy3, hyprspace, hyprsplit, hyprgrass, 
        hypr-dynamic-cursors, imgborders, hypr-darkwindow, 
        borders-plus-plus, hyprbars, hyprfocus
      '';
      example = [
        "hy3"
        "hyprspace"
        "hypr-dynamic-cursors"
      ];
    };

    # ─── MONITORS ─────────────────────────────────────────────
    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = ''
        Monitor configuration. Each entry should have:
        - name: monitor name (e.g., "DP-1")
        - resolution: "1920x1080@144"
        - position: "0x0"
        - scale: 1
      '';
      example = [
        { name = "DP-1"; resolution = "1920x1080@144"; position = "0x0"; scale = 1; }
        { name = "HDMI-A-1"; resolution = "1920x1080@60"; position = "1920x0"; scale = 1; }
      ];
    };

    # ─── WORKSPACES ───────────────────────────────────────────
    workspaces = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Workspace to monitor assignments";
      example = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:HDMI-A-1"
      ];
    };

    # ─── GENERAL SETTINGS ─────────────────────────────────────
    general = {
      gaps_in = lib.mkOption {
        type = lib.types.int;
        default = 4;
        description = "Inner window gaps";
      };
      gaps_out = lib.mkOption {
        type = lib.types.int;
        default = 8;
        description = "Outer window gaps";
      };
      border_size = lib.mkOption {
        type = lib.types.int;
        default = 2;
        description = "Window border size";
      };
      active_border_color = lib.mkOption {
        type = lib.types.str;
        default = "rgba(bb9af7ff) rgba(7aa2f7ff) 45deg";
        description = "Active window border color (can be gradient)";
      };
      inactive_border_color = lib.mkOption {
        type = lib.types.str;
        default = "rgba(1a1b26ff)";
        description = "Inactive window border color";
      };
    };

    # ─── DECORATION SETTINGS ──────────────────────────────────
    decoration = {
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 0;
        description = "Window corner rounding (0 for sharp)";
      };
      active_opacity = lib.mkOption {
        type = lib.types.float;
        default = 0.98;
        description = "Active window opacity (0-1)";
      };
      inactive_opacity = lib.mkOption {
        type = lib.types.float;
        default = 0.88;
        description = "Inactive window opacity (0-1)";
      };
      shadow = {
        enable = lib.mkEnableOption "Window shadows" // { default = true; };
        range = lib.mkOption {
          type = lib.types.int;
          default = 20;
          description = "Shadow blur range";
        };
        render_power = lib.mkOption {
          type = lib.types.int;
          default = 4;
          description = "Shadow render power";
        };
        color = lib.mkOption {
          type = lib.types.str;
          default = "rgba(000000aa)";
          description = "Shadow color";
        };
      };
      blur = {
        enable = lib.mkEnableOption "Window blur" // { default = true; };
        size = lib.mkOption {
          type = lib.types.int;
          default = 6;
          description = "Blur size";
        };
        passes = lib.mkOption {
          type = lib.types.int;
          default = 3;
          description = "Number of blur passes";
        };
      };
    };

    # ─── KEYBINDS ─────────────────────────────────────────────
    keybinds = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Custom keybind overrides";
      example = {
        "SUPER, Return" = "exec, ghostty";
        "SUPER, Q" = "killactive";
        "SUPER, F" = "fullscreen";
      };
    };

    # ─── EXEC-ONCE COMMANDS ──────────────────────────────────
    execOnce = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Commands to run once on Hyprland startup";
      example = [
        "waybar"
        "nm-applet --indicator"
        "blueman-applet"
        "swww-daemon"
        "wl-paste --watch cliphist store"
      ];
    };

    # ─── SCRATCHPADS ──────────────────────────────────────────
    scratchpads = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "Scratchpad window configurations";
      example = [
        {
          name = "dropdown";
          class = "ghostty-dropterm";
          command = "ghostty --class=ghostty-dropterm";
          size = "85% 50%";
          position = "7.5% 4%";
          workspace = "special:dropdown";
        }
        {
          name = "sysmon";
          class = "ghostty-sysmon";
          command = "ghostty --class=ghostty-sysmon -e amdgpu_top";
          size = "80% 60%";
          position = "10% 20%";
          workspace = "special:sysmon";
        }
      ];
    };

    # ─── ENVIRONMENT VARIABLES ───────────────────────────────
    sessionVariables = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        NIXOS_OZONE_WL = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
      };
      description = "Environment variables to set for the Hyprland session";
    };
  };
}
