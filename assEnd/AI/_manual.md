# molecular/AI — Manual

## What this category is
Everything here is your local-AI stack: model runners (koboldcpp, LM
Studio), a chat frontend (SillyTavern), model-downloading tools
(huggingface, ai-tools), and your voice-dictation pipeline
(whispercpp + nerd-dictation), plus the Vulkan switch that ties GPU
acceleration together across the stack.

## What's in here
8 modules: koboldcpp, lmstudio, sillytavern, huggingface, whispercpp,
nerd-dictation, ai-tools, vulkan.

## How each module is structured
Same three-file split as every other category: `config.nix` (options),
`module.nix` (what's actually turned on), `default.nix` (glue), plus
`_manual.md` / `_manifest.md` / `_cheatsheets.md` and `_notes.md` where
something needed flagging.

---

## Your hardware, in plain terms
32GB RAM incoming, 2TB storage incoming, AMD Ryzen 5 5600H with a Vega 7
iGPU. That iGPU doesn't have solid ROCm support (ROCm is AMD's CUDA
equivalent, and it's picky about which GPUs it actually supports well) --
Vulkan is the correct, working path for GPU-accelerated inference on this
hardware, which is exactly why koboldcpp and whisper.cpp here both default
to `useVulkan = true`, and why the `vulkan` module exists as a system-wide
switch. CUDA is Nvidia-only and irrelevant to your hardware entirely --
correct to leave it out.

## The voice-dictation pipeline specifically
You described wanting dictation as accurate as a good phone
speech-to-text feature -- "push a button, talk, it just works." Here's the
actual chain of pieces that makes that happen, and where the levers are:

1. **You press a keybind** (bound in Hyprland, not in this repo).
2. **nerd-dictation** starts listening, records audio while you talk.
3. **whisper.cpp** transcribes the recording to text (this is the actual
   speech-recognition model doing the work -- accuracy lives here).
4. **wtype** (or ydotool, see the conflict noted below) types the
   transcribed text into whatever window has focus.

### Where to put your attention for dictation quality
- **Model size** (`whispercpp`'s `model` option: tiny/base/small/medium/
  large) is the single biggest accuracy lever. `base` is fast but
  noticeably rougher than a phone's dictation. Try `small` first --
  meaningfully more accurate, still fast enough on Vulkan-accelerated Vega
  7, and your 32GB RAM has plenty of headroom for it. `medium` is worth
  testing too if `small` isn't good enough; you'll feel the slowdown
  before you run out of RAM.
- **Keybind mismatch**: `nerd-dictation`'s module.nix currently sets
  Alt+Shift+V as a placeholder, but your own notes describe SUPER+Space.
  Fix that in `module.nix`, and make sure Hyprland's own bind config
  actually calls this the same way -- a mismatch here is the single most
  likely reason dictation would silently "not work."
- **Two typing-injection tools exist and only one should be relied on**:
  `nerd-dictation` depends on `wtype` here, while `atomic/srvc/ydotool.nix`
  is a separate daemon doing the same job independently. Pick one as your
  real path -- whichever one Hyprland/nerd-dictation is actually calling --
  so you're not debugging the wrong tool when text doesn't appear.

## Local LLM setup -- what's Nix's job vs. yours
Nix installs the engines (koboldcpp, LM Studio) and gets Vulkan wired up.
It does **not**, and can't reasonably, manage:
- **Actual model files** (.gguf weights) -- these are multi-gigabyte
  binary downloads, not something to pull through Nix. Use `huggingface`
  or `ai-tools`' aria2/curl to fetch them yourself into a folder you pick
  (e.g. `~/models/`).
- **Running koboldcpp as an always-on background service** -- right now
  it's just an installed binary you launch by hand. If you want it running
  persistently (so scripts/SillyTavern can always reach its API without
  you starting it first), that's a systemd user service you'd add
  yourself -- a good fit for the scripting work you mentioned already
  being underway. Rough shape: a `systemd.user.services.koboldcpp` unit
  with `ExecStart` pointing at the koboldcpp binary plus your model path
  and `--api` flag, `WantedBy = [ "graphical-session.target" ]`.
- **LM Studio's backend selection** -- Vulkan vs CPU is chosen inside its
  own UI after launch, not through this Nix config. Given your ROCm
  concerns, that's specifically where to double-check it's set to Vulkan.

## The orphaned "master AI toggle" idea
The original `vulkan.nix` had a disconnected option,
`mogis.artfHst.enable`, described as a "master toggle for AI + hosting
modules" -- nothing in the whole dump actually used it. It wasn't carried
forward as a real option since it didn't connect to anything, but the
concept itself lines up with your own `hstAI` abbreviation from your
broader naming plans. If you want one real switch that turns your whole
AI + hosting layer on/off together later, that's a legitimate thing to
build for real -- just wasn't functioning here.
