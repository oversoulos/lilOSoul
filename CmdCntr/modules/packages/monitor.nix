{ pkgs, ... }:
{
  # System monitoring + interaction, minimal package count:
  # - Mission Center: GUI, view-only, CPU/RAM/disk/network + Vega 7 iGPU
  # - CoreCtrl: AMD-specific, view AND live-adjust GPU power/clock
  # Both get launched hidden and toggled via hotkey as Hyprland "scratchpad"
  # style windows — see CmdCntr/modules/hyprland/scratchpads.nix — so
  # neither clutters Waybar or your open-window list.
  home.packages = with pkgs; [
    mission-center
    corectrl
  ];
}
