
## AI observations (not acted on)

### Plugin ecosystem
We have definitions for 10+ plugins but none are currently enabled. Should we enable some by default?

### UWSM integration
`withUWSM = true` is set, but we need to ensure SDDM knows to launch the `hyprland-uwsm.desktop` entry.

### Lua config vs Nix config
Right now we're mixing:
- `hypr.lua` — home-manager style, copies lua files
- This module — Nix-generated config

We should choose one approach and stick with it.

### DMS integration points
DMS needs to be started from Hyprland's `exec-once` or as a systemd service. Currently `hypr.lua` uses `exec_once("waybar")` — we'll replace waybar with DMS.

### What to explore later
- Per-workspace layouts
- Dynamic monitor detection
- Multi-profile support (gaming, dev, presentation)
- Hyprland's built-in Lua API
