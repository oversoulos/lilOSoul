
**Category:** ui / desktop
**Option namespace:** `programs.hyprland`

## Module Structure
- `config.nix` — defines ALL possible options
- `module.nix` — sets the actual values (maxed out)
- `default.nix` — imports both
- `_manual.md`, `_manifest.md`, `_cheatsheets.md`, `_notes.md` — documentation

## Where it's imported
This module should be imported by `assEnd/ui/default.nix`, which is imported by your main `configuration.nix`.

## Features exposed as options

| Category | Options |
|----------|---------|
| **Core** | enable, package, withUWSM |
| **X11** | xwayland.enable, xwayland.package |
| **Plugins** | plugins (list) |
| **Monitors** | monitors, workspaces |
| **General** | gaps_in, gaps_out, border_size, active_border_color, inactive_border_color |
| **Decorations** | rounding, active_opacity, inactive_opacity, shadow, blur |
| **Keybinds** | keybinds (attrset) |
| **Startup** | execOnce (list) |
| **Scratchpads** | scratchpads (list of attrs) |
| **Env** | sessionVariables (attrs) |

## Available plugins (all ready to toggle)
- hy3 — i3/sway-like manual tiling
- hyprspace — workspace overview
- hyprsplit — awesome/dwm-like workspaces
- hyprgrass — touch gestures
- hypr-dynamic-cursors — realistic cursor physics
- imgborders — tiling image borders
- hypr-darkwindow — invert colors on windows
- borders-plus-plus — multiple borders
- hyprbars — window title bars
- hyprfocus — flashfocus effect

## Integration points
- **UWSM**: Session management (enabled by default)
- **DMS**: Shell/panel layer (runs alongside)
- **SDDM**: Display manager (launches Hyprland)
- **Hypridle**: Idle management
- **Hyprlock**: Screen locking
- **Hyprpaper**: Wallpaper management
