
**Category:** ui / shell
**Option namespace:** `programs.dms-shell`

## Module Structure
- `config.nix` — defines ALL possible options
- `module.nix` — sets the actual values (all on)
- `default.nix` — imports both
- `dashboards/` — your custom UI plugins
- `_manual.md`, `_manifest.md`, `_cheatsheets.md`, `_notes.md` — documentation

## Features exposed as options

| Category | Options |
|----------|---------|
| **Core** | enable, package |
| **Systemd** | systemd.enable, systemd.target, systemd.restartIfChanged |
| **Features** | enableSystemMonitoring, enableVPN, enableDynamicTheming, enableAudioWavelength, enableCalendarEvents, enableClipboardPaste |
| **Framework** | quickshell.package |
| **Dashboards** | dashboards (attrset of plugins) |

## Integration points
- **Hyprland**: DMS runs inside the compositor
- **UWSM**: Attaches to graphical-session.target
- **Quickshell**: Framework layer
- **Hyprpaper**: Dynamic theming integration
