{ config, pkgs, lib, ... }:

let
  cfg = config.programs.ai-tools;
in

{
  options.programs.ai-tools = {
    enable = lib.mkEnableOption "General-purpose AI-adjacent CLI toolkit";

    tools = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [ curl aria2 jq git-lfs ];
      description = "Tools installed by this module.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = cfg.tools;
  };

  # -- Placeholder for future integration hooks --
  # Nothing wired up yet. This whole module is a reconstructed placeholder
  # (see _notes.md) -- likely candidates once you know what you actually
  # want here: a script wrapper for batch model downloads, or a helper for
  # converting/quantizing GGUF models.
}
