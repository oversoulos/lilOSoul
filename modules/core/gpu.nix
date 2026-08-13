{ pkgs, ... }:
{
  # Graphics acceleration — needed for Hyprland/Wayland to render properly.
  # This machine has a Ryzen 5 5600H with a Vega 7 integrated GPU (AMD).
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # helps with some apps/games expecting 32-bit GL
  };

  # CoreCtrl — lets you view AND live-adjust the Vega 7's power/clock from
  # the desktop (paired with the CoreCtrl app installed at the user level).
  # This NixOS module wires up the permission (polkit) rule automatically
  # so it doesn't ask for a password every time you use it.
  programs.corectrl.enable = true;
}
