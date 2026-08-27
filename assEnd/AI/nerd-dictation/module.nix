{ config, lib, ... }:

# Active configuration for nerd-dictation.
# config.nix declares what's possible, this file decides what ovrOS uses now.
#
# NOTE: default keybind here is Alt+Shift+V. Your own notes describe
# SUPER+Space as the intended dictation trigger -- change `keybind` below
# to match what you actually want, and make sure Hyprland's own keybind
# config calls this the same way.
{
  programs.nerd-dictation = {
    enable = true;
    keybind = "Alt+Shift+V"; # <- confirm/change this against your real intent
    model = "base";          # <- consider "small" for better accuracy
  };
}
