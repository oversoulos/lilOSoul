#!/usr/bin/env bash
set -euo pipefail

# OvrOS installer — unrolls the full repo into ./OvrOS in your current directory.
# Run this in an empty-ish working folder, then cd into OvrOS and follow the README.

mkdir -p OvrOS
cd OvrOS

mkdir -p 'CmdCntr'
mkdir -p 'CmdCntr/modules'
mkdir -p 'CmdCntr/modules/hyprland'
mkdir -p 'CmdCntr/modules/packages'
mkdir -p 'hosts'
mkdir -p 'hosts/lilOSoul'
mkdir -p 'modules'
mkdir -p 'modules/core'
mkdir -p 'modules/desktop'
mkdir -p 'scripts'

cat > '.gitignore' << 'FILE_EOF_a084b794bc'
# Nix build output symlinks
result
result-*

# direnv cache, if you use it later
.direnv/

# Editor/OS junk
*.swp
*.swo
.DS_Store
FILE_EOF_a084b794bc

cat > 'CmdCntr/default.nix' << 'FILE_EOF_fe41fd88ca'
{ pkgs, username, ... }:
{
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/neovim.nix
    ./modules/yazi.nix
    ./modules/podman.nix
    ./modules/dictation.nix
    ./modules/packages
    ./modules/hyprland
    ./theme.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
FILE_EOF_fe41fd88ca

cat > 'CmdCntr/modules/dictation.nix' << 'FILE_EOF_be081978f4'
{ pkgs, ... }:
{
  # koboldcpp / whisper.cpp / voice-anywhere dictation — INTENTIONALLY LEFT
  # AS A STUB, not a working config, for one honest reason: I can't
  # currently confirm these exist under those exact names in nixpkgs
  # without risking putting a package name in here that doesn't exist and
  # breaking your whole build on first try. Rather than guess and hand you
  # something that silently fails, here's the real state and the real
  # options, so you can pick with full info instead of me picking blind:
  #
  # 1. koboldcpp — you've already built this manually before (in ~/ai on a
  #    prior machine). If it's not a clean nixpkgs package, running it the
  #    same way you already know (manual/binary, or its own repo's install
  #    script) is the most reliable path — a `home.packages` entry isn't
  #    required for that; it can just live in your home directory like
  #    before, outside Nix entirely, and still work fine.
  #
  # 2. Voice-to-text "anywhere," like a keyboard:
  #    - whisper.cpp: transcription engine, heavier, more accurate.
  #    - nerd-dictation: lighter, purpose-built for exactly this — hotkey,
  #      talk, text appears wherever your cursor is focused.
  #    - Either one needs pairing with a Wayland text-injection tool
  #      (`wtype` or `ydotool`) to actually type the transcribed text into
  #      whatever window is focused — transcription alone doesn't do that
  #      part.
  #
  # When you're ready to lock this in, tell me which pairing you want
  # (nerd-dictation+wtype is the simplest/lightest) and I'll wire up a real
  # working module here instead of this note.

  home.packages = [ ];
}
FILE_EOF_be081978f4

cat > 'CmdCntr/modules/ghostty.nix' << 'FILE_EOF_c48e2147a7'
{ pkgs, ... }:
{
  # If your home-manager channel doesn't yet ship `programs.ghostty`,
  # comment this block out and use `home.packages = [ pkgs.ghostty ];`
  # instead, then configure via ~/.config/ghostty/config directly.
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      theme = "catppuccin-mocha";
      window-padding-x = 8;
      window-padding-y = 8;
    };
  };
}
FILE_EOF_c48e2147a7

cat > 'CmdCntr/modules/git.nix' << 'FILE_EOF_f45faa122c'
{ ... }:
{
  # Syntax fixed (values now properly quoted strings). Name/email left
  # blank on purpose since neither was given — fill these in whenever, or
  # leave blank and git will still work locally, it just won't attach an
  # identity to commits until this is set.
  programs.git = {
    enable = true;
    userName = ""; # <-- fill in
    userEmail = ""; # <-- fill in
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
FILE_EOF_f45faa122c

cat > 'CmdCntr/modules/hyprland/base.nix' << 'FILE_EOF_67699c9519'
{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = "ghostty";
      "$fileManager" = "ghostty -e yazi";
      "$menu" = "wofi --show drun";
      "$liveConfig" = "~/.local/bin/hypr-live-config";

      exec-once = [
        "waybar"
        "nm-applet --indicator"
        "blueman-applet"
        # Polkit agent — needed for GUI permission prompts (CoreCtrl relies
        # on this too) so apps can ask for elevated access without a
        # terminal sudo prompt appearing.
        "${pkgs.hyprpolkitagent}/bin/hyprpolkitagent"
      ];

      bind = [
        "SUPER, Return, exec, $terminal"
        "SUPER, Q, killactive"
        "SUPER, E, exec, $fileManager"
        "SUPER, R, exec, $menu"
        "SUPER, C, exec, $liveConfig"
        "SUPER, M, exit"
        "SUPER, V, togglefloating"
        "SUPER, F, fullscreen"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
      };

      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 0.95;
      };

      animations.enabled = true;
    };
  };
}
FILE_EOF_67699c9519

cat > 'CmdCntr/modules/hyprland/default.nix' << 'FILE_EOF_516c9dfbab'
{
  imports = [
    ./base.nix
    ./waybar.nix
    ./live-ui.nix
    ./scratchpads.nix
  ];
}
FILE_EOF_516c9dfbab

cat > 'CmdCntr/modules/hyprland/live-ui.nix' << 'FILE_EOF_7f7f4385fa'
{ pkgs, ... }:
let
  hyprLiveConfig = pkgs.writeShellScriptBin "hypr-live-config" ''
    set -eu

    menu_entry="$(printf '%s\n' \
      'Balanced (default)' \
      'Compact (more windows)' \
      'Presentation (single focus)' \
      'Open Theme UI (nwg-look)' \
      'Open Display UI (wdisplays)' | wofi --dmenu --prompt 'Hyprland live config')"

    case "$menu_entry" in
      "Balanced (default)")
        lua "$HOME/.config/hypr/lua/live-config.lua" balanced
        ;;
      "Compact (more windows)")
        lua "$HOME/.config/hypr/lua/live-config.lua" compact
        ;;
      "Presentation (single focus)")
        lua "$HOME/.config/hypr/lua/live-config.lua" presentation
        ;;
      "Open Theme UI (nwg-look)")
        exec nwg-look
        ;;
      "Open Display UI (wdisplays)")
        exec wdisplays
        ;;
      *)
        exit 0
        ;;
    esac
  '';
in
{
  home.packages = [ hyprLiveConfig pkgs.lua ];

  xdg.configFile."hypr/lua/live-config.lua".text = ''
    local preset = arg[1]

    local function run(command)
      os.execute(command)
    end

    if preset == "balanced" then
      run("hyprctl keyword general:gaps_in 4")
      run("hyprctl keyword general:gaps_out 8")
      run("hyprctl keyword general:border_size 2")
      run("hyprctl keyword decoration:rounding 8")
    elseif preset == "compact" then
      run("hyprctl keyword general:gaps_in 1")
      run("hyprctl keyword general:gaps_out 2")
      run("hyprctl keyword general:border_size 1")
      run("hyprctl keyword decoration:rounding 2")
    elseif preset == "presentation" then
      run("hyprctl keyword general:gaps_in 12")
      run("hyprctl keyword general:gaps_out 18")
      run("hyprctl keyword general:border_size 3")
      run("hyprctl keyword decoration:rounding 14")
    end
  '';
}
FILE_EOF_7f7f4385fa

cat > 'CmdCntr/modules/hyprland/scratchpads.nix' << 'FILE_EOF_48cdc3631e'
{ ... }:
{
  # Mission Center (system monitor + iGPU view) and CoreCtrl (GPU
  # view+adjust) launch hidden on startup, then toggle into view with a
  # hotkey — dropdown-style, nothing sits permanently on Waybar or your
  # open-window list.
  #
  # NOTE on keybinds: SUPER+M was already used by the base config for
  # "exit Hyprland" — did not touch or overwrite that. Used SUPER+D /
  # SUPER+SHIFT+D instead (unused in the base config) to avoid a collision.
  # Rename these any time in this file if you'd rather have different keys.
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "[workspace special:sysmon silent] mission-center"
      "[workspace special:gpu silent] corectrl"
    ];

    bind = [
      "SUPER, D, togglespecialworkspace, sysmon"
      "SUPER SHIFT, D, togglespecialworkspace, gpu"
    ];
  };
}
FILE_EOF_48cdc3631e

cat > 'CmdCntr/modules/hyprland/waybar.nix' << 'FILE_EOF_ac3558f007'
{ ... }:
{
  programs.waybar.enable = true;

  xdg.configFile."waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["clock"],
      "modules-right": ["pulseaudio", "network", "cpu", "memory", "tray"],
      "clock": {
        "format": "{:%a %b %d  %H:%M}"
      },
      "network": {
        "format-wifi": "  {essid}",
        "format-ethernet": "󰈀  {ifname}",
        "format-disconnected": "󰖪  offline"
      },
      "pulseaudio": {
        "format": "  {volume}%",
        "format-muted": " muted"
      },
      "cpu": {
        "format": "  {usage}%"
      },
      "memory": {
        "format": "  {percentage}%"
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      font-family: JetBrainsMono Nerd Font;
      font-size: 13px;
      min-height: 0;
    }

    window#waybar {
      background: rgba(17, 17, 27, 0.92);
      color: #cdd6f4;
    }

    #workspaces button {
      padding: 0 8px;
      color: #bac2de;
    }

    #clock,
    #network,
    #pulseaudio,
    #cpu,
    #memory,
    #tray {
      padding: 0 10px;
      margin: 2px 2px;
    }
  '';
}
FILE_EOF_ac3558f007

cat > 'CmdCntr/modules/neovim.nix' << 'FILE_EOF_cd88c91763'
{ pkgs, ... }:
{
  # "Maxed" here means: solid, declarative day-one defaults, with vim as
  # your notepad covered. LazyVim / a plugin ecosystem is intentionally NOT
  # wired in yet — that's next-phase scope (theming/tooling pass), same as
  # Hyprland's own theming. Adding LazyVim later means pointing this at a
  # starter config or building extraConfig/plugins here once you're in and
  # ready.
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set number relativenumber
      set clipboard=unnamedplus
      set ignorecase
      set smartcase
      set expandtab
      set shiftwidth=2
      set tabstop=2
      set termguicolors
      set mouse=a
      set undofile
    '';
  };
}
FILE_EOF_cd88c91763

cat > 'CmdCntr/modules/packages/apps.nix' << 'FILE_EOF_26d9000831'
{ pkgs, ... }:
{
  # New app additions, locked in this pass.
  home.packages = with pkgs; [
    # Browser — going with Brave here since it's a standard, reliable
    # nixpkgs package with no extra setup. You mentioned Zen too: Zen
    # Browser is NOT in official nixpkgs (it needs its own separate flake
    # input to add cleanly), so I didn't silently swap it in — flagging it
    # instead. If you want Zen specifically, say so and we add that input
    # properly rather than guessing at it here.
    brave

    # Discord — vesktop is Discord + Vencord's mod features bundled into
    # one client, which covers what you asked for (Discord + Vencord) in a
    # single package rather than two.
    vesktop

    obs-studio
    obsidian
    xfce.thunar
  ];
}
FILE_EOF_26d9000831

cat > 'CmdCntr/modules/packages/cli.nix' << 'FILE_EOF_fb2a2be587'
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    eza
    bat
    fzf
    tree
    p7zip
  ];
}
FILE_EOF_fb2a2be587

cat > 'CmdCntr/modules/packages/default.nix' << 'FILE_EOF_c79cfe0c1c'
{
  imports = [
    ./cli.nix
    ./desktop.nix
    ./media.nix
    ./apps.nix
    ./monitor.nix
  ];
}
FILE_EOF_c79cfe0c1c

cat > 'CmdCntr/modules/packages/desktop.nix' << 'FILE_EOF_2e225ec671'
{ pkgs, ... }:
{
  # Core desktop utility packages Hyprland's own config relies on
  # (screenshotting, clipboard, applets, theme/display GUIs).
  home.packages = with pkgs; [
    wofi
    wl-clipboard
    grim
    slurp
    swappy
    networkmanagerapplet
    blueman
    pavucontrol
    nwg-look
    wdisplays
  ];
}
FILE_EOF_2e225ec671

cat > 'CmdCntr/modules/packages/media.nix' << 'FILE_EOF_0bdba2c53f'
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    imv   # image viewer
    mpv   # video/media player
  ];
}
FILE_EOF_0bdba2c53f

cat > 'CmdCntr/modules/packages/monitor.nix' << 'FILE_EOF_4efdd61021'
{ pkgs, ... }:
{
  # System monitoring + interaction, minimal package count:
  # - Mission Center: GUI, view-only, CPU/RAM/disk/network + Vega 7 iGPU
  # - CoreCtrl: AMD-specific, view AND live-adjust GPU power/clock
  # Both get launched hidden and toggled via hotkey as Hyprland "scratchpad"
  # style windows — see CmdCntr/modules/hyprland/scratchpads.nix — so
  # neither clutters Waybar or your open-window list.
  home.packages = with pkgs; [
    mission-center
    corectrl
  ];
}
FILE_EOF_4efdd61021

cat > 'CmdCntr/modules/podman.nix' << 'FILE_EOF_73f1f9eeec'
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    podman-compose
    podman-tui
  ];
}
FILE_EOF_73f1f9eeec

cat > 'CmdCntr/modules/shell.nix' << 'FILE_EOF_17288570ac'
{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake .#$(hostname)";
      ovros = "./scripts/deploy-ovros.sh";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
FILE_EOF_17288570ac

cat > 'CmdCntr/modules/yazi.nix' << 'FILE_EOF_52c279e95d'
{ ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
FILE_EOF_52c279e95d

cat > 'CmdCntr/theme.nix' << 'FILE_EOF_43b7a25a73'
{ pkgs, ... }:
{
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}
FILE_EOF_43b7a25a73

cat > 'README.md' << 'FILE_EOF_04c6e90faa'
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
FILE_EOF_04c6e90faa

cat > 'flake.nix' << 'FILE_EOF_5451c7b5e2'
{
  description = "OvrOS — modular NixOS config for lilOSoul";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      hostname = "lilOSoul";
      username = "milk";

      lib = nixpkgs.lib;
    in {
      nixosConfigurations.${hostname} = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username hostname; };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-bak";
            home-manager.extraSpecialArgs = { inherit inputs username; };
            home-manager.users.${username} = import ./CmdCntr;
          }
        ];
      };
    };
}
FILE_EOF_5451c7b5e2

cat > 'hosts/lilOSoul/configuration.nix' << 'FILE_EOF_0454d1289d'
{ config, pkgs, lib, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/desktop
  ];

  networking.hostName = hostname;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    # Single-user machine, no login manager beyond this. Password is set in
    # plain text here (`initialPassword`) which NixOS hashes into place on
    # first build — simplest option for a single-user box. Known tradeoff:
    # this file is readable in the repo, including while public during
    # install (see README). Change any time with `passwd` once booted, or
    # switch this to `hashedPassword` later if wanted.
    initialPassword = "4713";
    extraGroups = [
      "wheel"          # sudo
      "networkmanager" # network control
      "video"          # GPU/display access
      "audio"          # sound devices
      "podman"         # rootless containers
      "corectrl"       # lets CoreCtrl adjust GPU without a password prompt each time
      "input"          # needed by dictation tools (nerd-dictation/ydotool) to inject keystrokes
    ];
    shell = pkgs.zsh;
  };

  # zsh is set as the user's shell above, so it must be enabled system-wide too
  programs.zsh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Do NOT bump this casually
  # after initial install — see the NixOS manual.
  system.stateVersion = "24.11";
}
FILE_EOF_0454d1289d

cat > 'hosts/lilOSoul/hardware-configuration.nix' << 'FILE_EOF_692da182b5'
# PLACEHOLDER — this file is NOT real hardware data.
# Before installing, replace this entire file with the output of:
#   sudo nixos-generate-config --root /mnt
# (see README "Quick start" section). The deploy script checks for the
# word PLACEHOLDER above and will refuse to install until this is replaced.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0000-0000";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/00000000-0000-0000-0000-000000000000"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
FILE_EOF_692da182b5

cat > 'modules/core/bluetooth.nix' << 'FILE_EOF_6aaee8c23d'
{ ... }:
{
  # Bluetooth engine — without this, the Bluetooth dashboard (blueman, at
  # user level) has nothing to actually control.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
FILE_EOF_6aaee8c23d

cat > 'modules/core/boot.nix' << 'FILE_EOF_f8ebd1160b'
{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
FILE_EOF_f8ebd1160b

cat > 'modules/core/containers.nix' << 'FILE_EOF_3cf1f3836c'
{ ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # lets you run `docker` commands against podman
    defaultNetwork.settings.dns_enabled = true;
  };
}
FILE_EOF_3cf1f3836c

cat > 'modules/core/default.nix' << 'FILE_EOF_9d8e750389'
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./nix-settings.nix
    ./fonts.nix
    ./containers.nix
    ./packages.nix
    ./gpu.nix
    ./bluetooth.nix
  ];
}
FILE_EOF_9d8e750389

cat > 'modules/core/fonts.nix' << 'FILE_EOF_320566b266'
{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig.defaultFonts = {
    emoji = [ "Noto Color Emoji" ];
  };
}
FILE_EOF_320566b266

cat > 'modules/core/gpu.nix' << 'FILE_EOF_6059face13'
{ pkgs, ... }:
{
  # Graphics acceleration — needed for Hyprland/Wayland to render properly.
  # This machine has a Ryzen 5 5600H with a Vega 7 integrated GPU (AMD).
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # helps with some apps/games expecting 32-bit GL
  };

  # CoreCtrl — lets you view AND live-adjust the Vega 7's power/clock from
  # the desktop (paired with the CoreCtrl app installed at the user level).
  # This NixOS module wires up the permission (polkit) rule automatically
  # so it doesn't ask for a password every time you use it.
  programs.corectrl.enable = true;
}
FILE_EOF_6059face13

cat > 'modules/core/locale.nix' << 'FILE_EOF_5def6d39e5'
{ ... }:
{
  time.timeZone = "America/New_York"; # <-- change to your timezone
  i18n.defaultLocale = "en_US.UTF-8";
}
FILE_EOF_5def6d39e5

cat > 'modules/core/networking.nix' << 'FILE_EOF_fc7f24e574'
{ pkgs, ... }:
{
  networking.networkmanager.enable = true;
  # NetworkManager (already enabled above) can manage WireGuard connections
  # directly through its GUI/CLI once you have a tunnel config or keys.
  # wireguard-tools is added here too for manual setup (wg, wg-quick) if
  # you'd rather configure a tunnel by hand — no tunnel is created by
  # default, this just makes the tools available either way.
  environment.systemPackages = [ pkgs.wireguard-tools ];

  networking.firewall.enable = true;
  # No ports opened by default — safe starting point for a single-user
  # desktop machine. Open specific ports later if a service needs it.
}
FILE_EOF_fc7f24e574

cat > 'modules/core/nix-settings.nix' << 'FILE_EOF_26ccb8c168'
{ ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
FILE_EOF_26ccb8c168

cat > 'modules/core/packages.nix' << 'FILE_EOF_2c845ebdbf'
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    wget
    git
    vim
    htop
    jq
    unzip
    zip
    pciutils
    usbutils
  ];
}
FILE_EOF_2c845ebdbf

cat > 'modules/desktop/audio.nix' << 'FILE_EOF_7cbe019fcc'
{ ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
FILE_EOF_7cbe019fcc

cat > 'modules/desktop/default.nix' << 'FILE_EOF_ae5b8b0797'
{
  imports = [
    ./hyprland.nix
    ./audio.nix
    ./greeter.nix
    ./polish.nix
  ];
}
FILE_EOF_ae5b8b0797

cat > 'modules/desktop/greeter.nix' << 'FILE_EOF_dffca2a395'
{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings.default_session.command =
      "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
  };
}
FILE_EOF_dffca2a395

cat > 'modules/desktop/hyprland.nix' << 'FILE_EOF_51ee88174e'
{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  security.pam.services.hyprlock = { };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps (Discord/Vesktop, OBS, etc.) use Wayland
  };
}
FILE_EOF_51ee88174e

cat > 'modules/desktop/polish.nix' << 'FILE_EOF_2030c074d2'
{ ... }:
{
  # dconf — needed for several GTK apps (Thunar included) to save and
  # persist their settings correctly under Wayland/Hyprland.
  programs.dconf.enable = true;

  # gvfs — gives Thunar (and other GTK file tools) trash support, mounting
  # removable drives, and network locations. Without this, Thunar runs but
  # several right-click actions silently don't work.
  services.gvfs.enable = true;
}
FILE_EOF_2030c074d2

cat > 'scripts/deploy-ovros.sh' << 'FILE_EOF_6b25704ebd'
#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<USAGE
Usage:
  $0 install <hostname> [target-root]
  $0 switch <hostname>
  $0 check <hostname>

Examples:
  $0 install lilOSoul /mnt
  $0 switch lilOSoul
  $0 check lilOSoul
USAGE
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

require_cmd nix

mode="${1:-}"
host="${2:-}"

if [[ -z "$mode" || -z "$host" ]]; then
  usage
  exit 1
fi

cd "$ROOT_DIR"

case "$mode" in
  install)
    target_root="${3:-/mnt}"
    hardware_file="hosts/${host}/hardware-configuration.nix"

    if [[ ! -f "$hardware_file" ]]; then
      echo "Missing ${hardware_file}. Create hosts/${host}/ first." >&2
      exit 1
    fi

    if grep -q "PLACEHOLDER" "$hardware_file"; then
      echo "${hardware_file} is still placeholder content." >&2
      echo "Generate and copy a real hardware config first:" >&2
      echo "  sudo nixos-generate-config --root ${target_root}" >&2
      echo "  sudo cp ${target_root}/etc/nixos/hardware-configuration.nix ${hardware_file}" >&2
      exit 1
    fi

    sudo nixos-install --flake ".#${host}"
    ;;
  switch)
    sudo nixos-rebuild switch --flake ".#${host}"
    ;;
  check)
    nix flake check --no-build
    nix eval ".#nixosConfigurations.${host}.config.system.build.toplevel.drvPath" >/dev/null
    echo "Flake check passed for host ${host}."
    ;;
  *)
    usage
    exit 1
    ;;
esac
FILE_EOF_6b25704ebd

chmod +x scripts/deploy-ovros.sh

echo "OvrOS unpacked into ./OvrOS"
echo "Next: cd OvrOS, replace hosts/lilOSoul/hardware-configuration.nix with real hardware output, then see README.md"
