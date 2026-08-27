
## AI observations (not acted on)

### Dashboards vs Plugins
DMS calls them "plugins" but we're renaming to "dashboards" in our config for clarity. They're the same thing.

### Quickshell version
DMS uses quickshell under the hood. If we need to upgrade, we can override `quickshell.package`.

### Hyprland integration
DMS should start *after* Hyprland is fully running. Currently using `graphical-session.target` which is correct.

### Dynamic theming
Requires `matugen` and a wallpaper daemon (we use swww). DMS will watch for wallpaper changes.

### What to explore later
- Custom DMS themes
- Additional widgets (weather, music player, etc.)
- Dashboard layouts
- Performance tuning
