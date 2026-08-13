{ pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [{ path = "screenshot"; blur_passes = 2; }];
      input-field = [{
        size = "250, 60";
        placeholder_text = "Password";
      }];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "${pkgs.hyprlock}/bin/hyprlock";
      };
      listener = [
        {
          timeout = 300; # 5 min idle -> lock
          on-timeout = "${pkgs.hyprlock}/bin/hyprlock";
        }
        {
          timeout = 600; # 10 min idle -> screen off
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      border-radius = 8;
    };
  };
}


