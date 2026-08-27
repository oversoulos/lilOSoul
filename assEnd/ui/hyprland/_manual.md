
## What this is
Hyprland is a dynamic tiling Wayland compositor with modern features:
- GPU-accelerated rendering
- Dynamic tiling with floating support
- Customizable animations and effects
- Plugin system for extending functionality
- Lua scripting for configuration

## Why it's here
ovrOS uses Hyprland as its primary display server. This module:
- Manages the compositor configuration
- Handles plugin loading
- Sets up monitors, workspaces, and keybindings
- Integrates with UWSM for systemd session management

## How it's wired up
- `config.nix` — declares all Hyprland options (plugins, monitors, keybinds, themes)
- `module.nix` — turns on Hyprland with maxed-out settings
- `default.nix` — imports both; this is what everything else points at

## Dependencies
- Hyprland package
- Optional: UWSM for session management
- Optional: Xwayland for X11 app compatibility
- Optional: Various plugins

## Integration with other modules
- **DMS**: Runs as the shell/panel layer inside Hyprland
- **SDDM**: Launches Hyprland as the desktop session
- **UWSM**: Manages the systemd session lifecycle

## Debugging
- Hyprland not starting? Check `programs.hyprland.enable = true` in module.nix
- Plugins not loading? Add them to `plugins` list
- Keybinds not working? Verify syntax in `keybinds` attrset
- Check UWSM status: `systemctl --user status hyprland`
- Check Hyprland logs: `journalctl -f -o cat /usr/bin/Hyprland`
