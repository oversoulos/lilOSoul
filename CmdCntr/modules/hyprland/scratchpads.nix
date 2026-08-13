{ ... }:
{
  # Mission Center (system monitor + iGPU view) and CoreCtrl (GPU
  # view+adjust) launch hidden on startup, then toggle into view with a
  # hotkey — dropdown-style, nothing sits permanently on Waybar or your
  # open-window list.
  #
  # NOTE on keybinds: SUPER+M was already used by the base config for
  # "exit Hyprland" — did not touch or overwrite that. Used SUPER+D /
  # SUPER+SHIFT+D instead (unused in the base config) to avoid a collision.
  # Rename these any time in this file if you'd rather have different keys.
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special:sysmon silent] mission-center"
      "[workspace special:gpu silent] corectrl"
    ];

    bind = [
      "SUPER, D, togglespecialworkspace, sysmon"
      "SUPER SHIFT, D, togglespecialworkspace, gpu"
    ];
  };
}
