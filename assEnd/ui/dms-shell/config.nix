
let
  cfg = config.programs.dms-shell;
in

{
  options.programs.dms-shell = {

    # ─── MAIN SWITCH ──────────────────────────────────────────
    enable = lib.mkEnableOption "DankMaterialShell (Wayland shell)";

    package = lib.mkPackageOption pkgs "dms-shell" { };

    # ─── SYSTEMD ──────────────────────────────────────────────
    systemd = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Start DMS automatically on login via systemd.";
      };
      target = lib.mkOption {
        type = lib.types.str;
        default = "graphical-session.target";
        description = "Systemd target to attach to.";
      };
      restartIfChanged = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Restart DMS when the package or config changes.";
      };
    };

    # ─── FEATURE TOGGLES ──────────────────────────────────────
    enableSystemMonitoring = lib.mkEnableOption "system monitoring widgets (installs dgop)";
    enableVPN = lib.mkEnableOption "VPN status widgets (installs glib + networkmanager)";
    enableDynamicTheming = lib.mkEnableOption "dynamic theming from wallpaper (installs matugen)";
    enableAudioWavelength = lib.mkEnableOption "audio visualizer (installs cava)";
    enableCalendarEvents = lib.mkEnableOption "calendar events (installs khal)";
    enableClipboardPaste = lib.mkEnableOption "clipboard history paste (installs wtype)";

    # ─── QUICKSHELL ────────────────────────────────────────────
    quickshell = {
      package = lib.mkPackageOption pkgs "quickshell" { };
    };

    # ─── DASHBOARDS (your custom UI) ──────────────────────────
    dashboards = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "this dashboard";
          src = lib.mkOption {
            type = lib.types.either lib.types.package lib.types.path;
            description = "Source of the dashboard (path to quickshell plugin)";
          };
        };
      });
      default = { };
      description = "Custom quickshell dashboards to load as DMS plugins";
      example = {
        solcmd = {
          enable = true;
          src = ./dashboards/solcmd;
        };
        systemmonitor = {
          enable = true;
          src = ./dashboards/systemmonitor;
        };
      };
    };
  };
}
