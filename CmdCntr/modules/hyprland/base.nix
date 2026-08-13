{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = "ghostty";
      "$fileManager" = "ghostty -e yazi";
      "$menu" = "wofi --show drun";
      "$liveConfig" = "~/.local/bin/hypr-live-config";

      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "blueman-applet"
        # Polkit agent — needed for GUI permission prompts (CoreCtrl relies
        # on this too) so apps can ask for elevated access without a
        # terminal sudo prompt appearing.
        "${pkgs.hyprpolkitagent}/bin/hyprpolkitagent"
      ];

      bind = [
        "SUPER, Return, exec, $terminal"
        "SUPER, Q, killactive"
        "SUPER, E, exec, $fileManager"
        "SUPER, R, exec, $menu"
        "SUPER, C, exec, $liveConfig"
        "SUPER, M, exit"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
      };

      animations.enabled = true;
    };
  };
}
