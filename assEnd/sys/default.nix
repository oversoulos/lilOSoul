{
  imports = [
    ../sys/greeter
    ../sys/display-manager
    ../sys/vulkan-tools
    ../sys/nextcloud
    ../sys/slurp
    ../sys/gtk
    ../sys/plymouth
    ../sys/glxinfo
    ../sys/amdgpu-top
    ../sys/tailscale
    ../sys/wl-clipboard
    ../sys/wtype
  ];

  # ../sys/wtype was written but missing from this imports list in the
  # original dump -- added here so it actually gets picked up. See
  # wtype/_notes.md for detail.
}
