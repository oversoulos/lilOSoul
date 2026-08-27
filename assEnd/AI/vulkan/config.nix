{ config, pkgs, lib, ... }:

let
  cfg = config.programs.ai-vulkan;
in

{
  options.programs.ai-vulkan = {
    enable = lib.mkEnableOption "GPU-accelerated (Vulkan) backend for local AI inference";
  };

  config = lib.mkIf cfg.enable {
    environment.variables.GGML_VULKAN = "1";
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. The original file also declared an orphaned
  # `mogis.artfHst.enable` option ("master toggle for AI + hosting modules")
  # that nothing else in the dump referenced -- not carried forward as a
  # real option here, but see this module's _notes.md: the concept overlaps
  # with your own `hstAI` naming and could be worth building for real later
  # as an actual cross-category master switch.
}
