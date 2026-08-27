{
  imports = [
    ../AI/koboldcpp
    ../AI/lmstudio
    ../AI/sillytavern
    ../AI/huggingface
    ../AI/whispercpp
    ../AI/nerd-dictation
    ../AI/ai-tools
    ../AI/vulkan
  ];

  # ../AI/ai-tools.nix was imported in the original dump but the file
  # itself never existed anywhere in the source -- rebuilt as a general
  # placeholder toolkit. See ai-tools/_notes.md.
  #
  # ../AI/vulkan.nix was structurally broken (no enable option, plus an
  # orphaned unrelated option) -- rebuilt as a real module. See
  # vulkan/_notes.md.
}
