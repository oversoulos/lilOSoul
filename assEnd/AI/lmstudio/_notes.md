# lmstudio — Notes (AI-assistant observations, not acted on)

This module doesn't expose a backend-selection option (Vulkan vs CPU vs ROCm) — that choice happens inside LM Studio's own UI after install, not through NixOS config. Given your ROCm-support concerns, that's specifically where you'd want to confirm it's set to Vulkan.
