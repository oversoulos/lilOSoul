{ pkgs, ... }:
{
  # koboldcpp — local AI text-generation engine. Confirmed real nixpkgs
  # package (not a stub anymore). Vulkan support is on by default on
  # Linux, which is what lets it use your Vega 7 for acceleration — same
  # graphics driver setup already enabled in modules/core/gpu.nix, nothing
  # extra needed beyond vulkan-tools (already added) for diagnostics.
  home.packages = with pkgs; [
    koboldcpp
  ];
}
