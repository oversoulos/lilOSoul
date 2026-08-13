{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  # NetworkManager (already enabled above) can manage WireGuard connections
  # directly through its GUI/CLI once you have a tunnel config or keys.
  # wireguard-tools is added here too for manual setup (wg, wg-quick) if
  # you'd rather configure a tunnel by hand — no tunnel is created by
  # default, this just makes the tools available either way.
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.firewall.enable = true;
  # No ports opened by default — safe starting point for a single-user
  # desktop machine. Open specific ports later if a service needs it.
}
