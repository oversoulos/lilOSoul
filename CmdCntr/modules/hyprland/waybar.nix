{ ... }:
{
  programs.waybar.enable = true;

  xdg.configFile."waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["clock"],
      "modules-right": ["pulseaudio", "network", "cpu", "memory", "tray"],
      "clock": {
        "format": "{:%a %b %d  %H:%M}"
      },
      "network": {
        "format-wifi": "  {essid}",
        "format-ethernet": "󰈀  {ifname}",
        "format-disconnected": "󰖪  offline"
      },
      "pulseaudio": {
        "format": "  {volume}%",
        "format-muted": " muted"
      },
      "cpu": {
        "format": "  {usage}%"
      },
      "memory": {
        "format": "  {percentage}%"
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      font-family: JetBrainsMono Nerd Font;
      font-size: 13px;
      min-height: 0;
    }

    window#waybar {
      background: rgba(17, 17, 27, 0.92);
      color: #cdd6f4;
    }

    #workspaces button {
      padding: 0 8px;
      color: #bac2de;
    }

    #clock,
    #network,
    #pulseaudio,
    #cpu,
    #memory,
    #tray {
      padding: 0 10px;
      margin: 2px 2px;
    }
  '';
}
