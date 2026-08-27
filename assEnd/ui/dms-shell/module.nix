{ config, lib, pkgs, ... }: {
  programs.dms-shell = {
    enable = true;

    # Core Native Features Handled Directly inside Quickshell Interface
    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    # Wayland targets managed via modern systemd session profiles
    systemd = {
      enable = true;
      target = "graphical-session.target"; # Fires directly upon stable UWSM initialization
      restartIfChanged = true;
    };

    # Custom Functional Lua Architecture Extensions Loaded into Workspace
    dashboards = {
widgetdash = {enable = true;src = ../dashboards/widgetdash; # Seamless local injection link};};};}
