# molecular/AI — Manifest

**Category:** molecular (composed/system-level groupings)
**Type:** AI (local LLM stack, voice dictation, model tooling)

## How to add a new module here
1. Make a new folder under `molecular/AI/<name>/`.
2. Give it `config.nix` (options + config), `module.nix` (the enable/settings
   file), and `default.nix` (imports both) -- same pattern as every other
   module here.
3. Add `../AI/<name>` to the `imports` list in `molecular/AI/default.nix`.
4. Add the matching docs: `_manual.md`, `_manifest.md`, `_cheatsheets.md`.

## Structure rules
- One module = one folder. No shared/multi-tool files.
- `config.nix` never sets real values, only declares what's possible.
- `module.nix` is the only place `enable = true` (or real settings) should live.
- Docs live beside the code, not inside it.

## Current integrations
All 8 modules are imported by `molecular/AI/default.nix`.

## Known issues
- `ai-tools.nix` was a phantom import (never existed in the dump) --
  rebuilt as a general placeholder toolkit, not a recovery.
- `vulkan.nix` was structurally broken (unconditional env var, orphaned
  unrelated option) -- rebuilt as a real module with a proper enable option.
- `nerd-dictation`'s default keybind (Alt+Shift+V) doesn't match your
  stated intent (SUPER+Space) -- needs correcting in `module.nix`.
- `nerd-dictation` and `atomic/srvc/ydotool` both do text-injection --
  only one should be the real path Hyprland calls.
- `koboldcpp` installs the binary only, no systemd service for always-on
  operation -- see `_manual.md`'s roadmap section for what that'd look like.
- `lmstudio`'s Vulkan/backend choice is made inside its own UI, not exposed
  as a Nix option.
