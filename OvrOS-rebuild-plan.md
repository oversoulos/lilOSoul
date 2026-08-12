# OvrOS Rebuild Plan — Running Document

Status: PASS 1 COMPLETE. Delivered as `ovros-install.sh` — run it in an empty
folder, it unrolls into `./OvrOS`. Verified the script reproduces the built
repo byte-for-byte before handing it back.

## Decisions made during the build that weren't explicitly locked before —
## flagging so nothing sneaks past you silently:

- `system.stateVersion` changed from `"26.05"` to `"24.11"` — 26.05 wasn't
  confirmed to be a real released NixOS version, 24.11 was already used
  elsewhere in the repo (home-manager side), so used that for consistency.
  This is a one-time value tied to your first install; easy to discuss if
  you want it different.
- Browser: went with **Brave**, not Zen — Zen isn't in official nixpkgs,
  see README "Known gaps" section for what adding it properly would take.
- Discord: went with **Vesktop** (Discord + Vencord bundled) instead of two
  separate packages, since that's what you described wanting.
- koboldcpp / whisper.cpp / dictation: NOT wired up — left as an honest
  stub in `CmdCntr/modules/dictation.nix` rather than guessing at package
  names that might not exist and breaking your build. Real options written
  out in that file's comments and in the README.
- Hyprland keybinds for the new scratchpads use `SUPER+D` / `SUPER+SHIFT+D`
  — picked those specifically because `SUPER+M` was already taken (exits
  Hyprland) and I didn't want to silently overwrite an existing bind.

---

## Locked identifiers

- Hostname: `lilOSoul`
- Username: `milk`
- Admin/login password: `4713` — FLAGGED: sits in a public repo during install,
  short/simple password, tradeoff acknowledged, not yet finalized how it gets
  applied (plain vs hashed vs other mechanism)
- Home-manager naming: `CmdCntr` — LOCKED. Replaces the whole `home/` folder
  (the entire user-level layer: themes, GUI tool configs, dashboards/
  interactives like pavucontrol/blueman/CoreCtrl/Mission Center, shell, git
  identity, Hyprland keybinds/look).
- Security naming: `bigBro` — PARKED, not assigned yet. Milk's instinct is
  this should live closer to networking (where actual exposure/risk is),
  rather than being its own separate module gathering pam/rtkit-type
  settings. Revisit once we're actually in the networking/firewall part of
  the #8 configurations pass — not a current concern.

## Open questions (must resolve before naming pass runs)

None remaining for now. `bigBro` placement deferred (see above), not blocking.

---

## Fix order (agreed)

1. Structural nesting
2. Naming / pathway mismatches
3. Redundancy
4. Hardcoded IDs + syntax errors (combined, fixed in the same pass per file,
   plus one final syntax sweep at the very end to catch anything missed)
5. `.gitignore`
6. Configurations (missing critical infra + intentional additions)
7. Deploy script (rewritten last, only once repo is fully finalized)

---

## 1. Structural nesting — TO FIX

- Outer `files/` wrapper folder is not part of the real project; real root is
  what's currently inside `files/nixos-config/`.
- Everything currently under `nixos-config/` is itself correctly structured —
  no changes needed to that internal layout.

## 2. Naming / pathway mismatches — TO FIX

- `flake.nix` currently sets hostname to `lilOvrOS`, but the folder is named
  `hosts/default/`. Neither matches the locked value `lilOSoul`. Both need to
  end up consistent.
- `configuration.nix` hardcodes `users.users.milk` directly instead of using
  the `username` variable already passed via `specialArgs`.

## 3. Redundancy — TO FIX

- Duplicate `README.md` (identical copies at two levels) — one gets removed
  once nesting is resolved, will likely be rewritten anyway for final version.
- Podman declared at both system level (`modules/core/containers.nix`, engine)
  and home level (`home/modules/podman.nix`, CLI tools `podman-compose` /
  `podman-tui`) — confirmed intentional (engine vs. interface), not a bug.

## 4. Hardcoded IDs / naming + syntax errors — TO FIX (combined pass)

- `git.nix`: `userName` / `userEmail` missing quotes (syntax error) AND
  currently set to placeholder values (needs milk's real values, or decide to
  leave unset for now).
- `hardware-configuration.nix`: multiple syntax errors independent of being
  placeholder data — stray `b` after a string, malformed `swapDevices` block,
  mismatched closing brace. Will be replaced by real machine output anyway,
  but errors should still be understood/logged.
- Fake/malformed placeholder UUIDs in hardware-configuration.nix — moot once
  real hardware output replaces the file, not worth hand-fixing.
- Final full-repo syntax sweep happens after all planned edits are done, to
  catch anything not touched during the targeted passes above.

## 5. `.gitignore` — TO DO

- At minimum: exclude the `result` symlink/folder that `nix build` generates.
- Anything else to exclude: TBD when we get there.

## 6. Configurations — missing critical infra (confirmed gaps)

- No password/login mechanism defined for user `milk` (ties to locked
  password `4713` above — mechanism still TBD).
- No GPU/graphics acceleration block (`hardware.graphics.enable` or
  equivalent) — relevant since hardware is Ryzen 5 5600H w/ Vega 7 iGPU.
- No polkit authentication agent running — needed for GUI permission prompts,
  and specifically needed for CoreCtrl (below) to apply GPU changes without
  repeated password prompts.
- No `dconf` service enabled — needed for some GTK apps to persist settings.
- Bluetooth: dashboard (`blueman`) is present at user level, but no Bluetooth
  engine is turned on at system level — currently nothing for it to control.
- `system.stateVersion = "26.05"` — needs confirming this is a real/intended
  NixOS release value.

## 6a. Configurations — planned additions (post-foundation, not yet built)

- **System/GPU monitoring, minimal package count, AMD Vega 7 iGPU:**
  - `Mission Center` — GUI, CPU/RAM/disk/network + iGPU usage in one window
    (view-only)
  - `CoreCtrl` — AMD-specific GPU monitor + live click-to-adjust power/clock
    (view + control)
  - Both to be bound as Hyprland **scratchpad** windows (hidden by default,
    hotkey brings them up as a dropdown/dock, hotkey again or click-away
    dismisses) — keeps Waybar and any open-app bar uncluttered.
- Waybar to stay lean: CPU% + RAM% only for now, no temps/extra widgets
  unless requested later.
- Bluetooth engine needs enabling system-side so `blueman` has something to
  control (separate from the smart-lights question below).
- **Smart lights over Bluetooth** — flagged as likely NOT a simple OS-level
  Bluetooth pairing task; most smart light brands need their own app, a hub,
  or something like Home Assistant. Parked as its own separate item, not
  folded into "turn Bluetooth on" — pick back up later with brand/model info
  if wanted.

## 7. Deploy script — PARKED

- To be rewritten only after the repo is otherwise fully finalized.
- Known issue in current script: its placeholder-detection check looks for
  the literal word `PLACEHOLDER` in `hardware-configuration.nix`, but the
  actual placeholder content doesn't contain that word — so the safety check
  currently wouldn't stop an install with a bad hardware file. To be addressed
  when the script is rewritten.

---

## Raw wishlist — packages/theming (captured, NOT designed yet — waiting for final prompt)

- Remove Firefox; replace with Zen or Brave (needs a decision between the two)
- Discord + Vencord
- OBS Studio
- Image/photo viewer (name unclear from voice-to-text, to confirm)
- Thunar (file manager)
- A GTK-based terminal
- p7zip
- Spotify
- Screenshot tool with region-select targeting (Hyprland-native option: `grim`
  + `slurp`, or `flameshot`)
- PDF viewer/editor (all-in-one if possible)
- Notepad-type app, or confirm vim covers this need
- Theming: wants things "pretty as f***" — fonts/icons/GTK+Hyprland theming,
  scope TBD in #8 pass
- Android connectivity, KDE-Connect-style (Linux equivalent: `kdeconnect`)
- Mentioned needing: Qt5 support, Vulkan support, "cobalt CPP" (unclear,
  needs clarifying — possibly a codec/media library reference)
- LazyVim for Neovim — confirmed want, not yet configured
- Want GUI terminal for interacting with monitor/interactive tools "unless it
  can all be in one thing"
- General ask: modules should be filled out with AS MANY config options as
  possible, toggled off by default, so milk can turn things on/off later
  without needing to come back and re-scope the module itself

## Notes / preferences to keep in mind throughout

- Single user, single machine (mini PC) — no multi-user complexity needed.
- Minimize package count wherever a single tool can reasonably cover a job;
  prefer tools that both monitor AND let you interact/adjust, not split
  across multiple packages, when such a tool exists.
- Hyprland UI should stay modular/uncluttered — favor hotkey-summoned
  scratchpad/dropdown panels over permanently visible bar widgets.
- vim/yazi/Hyprland theming (fonts, icons, LazyVim, plugin toggles) is
  explicitly scoped for later, once the foundation is locked — options to be
  laid out (prepackaged vs. linked-in) before anything is picked.
- Public repo is temporary/intentional — used only during install on a
  machine that gets reformatted repeatedly, then made private after. Not an
  oversight, already acknowledged.
- No "we'll harden/add it later" — things get locked in fully when addressed,
  not deferred and revisited repeatedly.
