# OvrOS — lilOSoul

Modular NixOS + Home Manager + Hyprland config for a single-user Ryzen 5
5600H / Vega 7 mini PC.

## Folder layout

```text
flake.nix
.gitignore
hosts/lilOSoul/
  configuration.nix
  hardware-configuration.nix   # PLACEHOLDER — replace before install, see below
modules/                       # system-level (applies no matter who's logged in)
  core/
    boot.nix
    networking.nix
    locale.nix
    nix-settings.nix
    fonts.nix
    containers.nix
    packages.nix
    gpu.nix          # graphics accel + CoreCtrl polkit rule
    bluetooth.nix     # Bluetooth engine
  desktop/
    hyprland.nix
    audio.nix
    greeter.nix
    polish.nix        # dconf + gvfs
CmdCntr/                        # home-manager — everything specific to you (milk)
  default.nix
  theme.nix
  modules/
    shell.nix
    git.nix
    ghostty.nix
    neovim.nix
    yazi.nix
    podman.nix
    dictation.nix      # STUB — see note below, not wired up yet
    packages/
      cli.nix
      desktop.nix
      media.nix
      apps.nix          # brave, vesktop, obs-studio, obsidian, thunar
      monitor.nix        # mission-center, corectrl
    hyprland/
      base.nix
      waybar.nix
      live-ui.nix
      scratchpads.nix    # Mission Center / CoreCtrl hotkey dropdowns
scripts/
  deploy-ovros.sh
```

## Quick start

### 1) Replace the hardware file

`hosts/lilOSoul/hardware-configuration.nix` is a PLACEHOLDER right now — it
will not work as-is. From the NixOS live ISO, after partitioning + mounting
disks at `/mnt`:

```sh
sudo nixos-generate-config --root /mnt
sudo cp /mnt/etc/nixos/hardware-configuration.nix ./hosts/lilOSoul/hardware-configuration.nix
sudo ./scripts/deploy-ovros.sh install lilOSoul /mnt
```

Reboot after install.

### 2) If already on NixOS and just switching config

```sh
sudo ./scripts/deploy-ovros.sh switch lilOSoul
```

### 3) Optional safety check before install/switch

```sh
./scripts/deploy-ovros.sh check lilOSoul
```

## What's already locked in

- Hostname `lilOSoul`, user `milk`, initial password `4713` (see the
  comment in `hosts/lilOSoul/configuration.nix` for the tradeoff on this —
  easy to change with `passwd` once booted).
- Audio (PipeWire) + Bluetooth (engine now on, `blueman` for the dashboard).
- Firewall on, `wireguard-tools` available for manual tunnel setup,
  NetworkManager can also handle WireGuard connections directly.
- Podman: system-level engine + user-level `podman-compose`/`podman-tui`.
- GPU acceleration for the Vega 7 iGPU, plus CoreCtrl wired with its own
  polkit rule so it doesn't ask for a password every time.
- Mission Center + CoreCtrl as hotkey-summoned scratchpad windows —
  `SUPER+D` toggles the system monitor, `SUPER+SHIFT+D` toggles CoreCtrl.
  Neither sits on Waybar or clutters your window list.
- Waybar kept lean: CPU% and RAM% only, no extra widgets.
- Apps: Ghostty, Yazi, Neovim (with sane defaults, no plugin ecosystem yet
  on purpose), Obsidian, Thunar, OBS Studio, Vesktop (Discord + Vencord in
  one client), Brave.

## Known gaps / things flagged instead of guessed at

- **Zen Browser** — not in official nixpkgs, needs its own flake input to
  add cleanly. Brave is in as the working browser for now; say the word if
  you want Zen added as a proper input instead of a guess.
- **koboldcpp / whisper.cpp / voice-to-text-anywhere** — `CmdCntr/modules/dictation.nix`
  is a stub with the real options written out, not a working config. I
  wasn't confident these package names exist cleanly in nixpkgs and didn't
  want to hand you a build that silently breaks. Tell me which pairing you
  want (nerd-dictation + wtype is the lightest option) and it gets wired up
  for real.
- **Webcam/mic** — should work automatically (kernel-level `v4l2` for the
  camera, PipeWire for the mic, same as your speakers) but this can't be
  fully confirmed until it's running on the actual hardware. Nothing to
  configure blind here.
- **git identity** — `CmdCntr/modules/git.nix` has `userName`/`userEmail`
  left blank (syntax is fixed, values just weren't given). Fill in anytime.

## Hyprland controls

- `SUPER + Return` → terminal
- `SUPER + E` → file manager in terminal
- `SUPER + R` → app launcher
- `SUPER + Shift + S` → area screenshot editor
- `SUPER + C` → live config menu (Balanced/Compact/Presentation layouts,
  theme UI, display UI) — note: this menu is a small shell script that
  calls a helper written in **Lua**, but Hyprland's actual config file
  (`base.nix` → `hyprland.conf` under the hood) is its own plain config
  language, not Lua. Both are real and both work, just wanted that
  distinction clear.
- `SUPER + D` → toggle Mission Center (system monitor)
- `SUPER + SHIFT + D` → toggle CoreCtrl (GPU monitor + adjust)

## Deliberately out of scope for this pass

Theming/fonts/icon expansion, LazyVim, and deeper plugin work were kept out
on purpose — that's the next phase once this foundation is confirmed
running and stable on real hardware, per the plan.
