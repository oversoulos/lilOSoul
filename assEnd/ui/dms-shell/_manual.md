
## What this is
DankMaterialShell (DMS) is a complete Wayland shell built on quickshell. It provides:
- System panel with workspaces, tray, clock
- Application launcher
- Widget system for custom dashboards
- Material Design aesthetics
- Dynamic theming

## Why it's here
ovrOS uses DMS as its UI shell layer. It runs alongside Hyprland and provides:
- The visual interface (panels, widgets)
- System integration (tray, notifications)
- Your custom dashboards (as plugins)

## How it's wired up
- `config.nix` — declares all DMS options (features, dashboards, systemd)
- `module.nix` — turns on DMS with all features
- `default.nix` — imports both
- `dashboards/` — your custom UI plugins

## Integration with other modules
- **Hyprland**: DMS runs inside Hyprland as a systemd service
- **UWSM**: DMS attaches to `graphical-session.target`
- **Quickshell**: The framework DMS is built on

## Debugging
- DMS not starting? Check `programs.dms-shell.enable = true`
- Check systemd status: `systemctl --user status dms`
- Dashboards not loading? Verify path in `dashboards.src`
- No widgets? Check feature toggles are enabled
