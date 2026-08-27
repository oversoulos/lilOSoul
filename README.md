# 🧠 ovrOS (Overlay Operating System)

ovrOS is a modular, declarative, reproducible workstation build running on **NixOS** and driven by the **Hyprland Wayland compositor**. It completely bypasses standard, unmanaged plain-text configuration files (`.conf`) in favor of a **unified Lua architecture** and declarative Nix modules.

This system is engineered for low-friction local AI development, secure networking, extreme privacy, and rapid keyboard-driven task execution.

---

## 🚀 Core Capabilities & What It Does Right Now

### 1. Unified Lua Control Engine
The entire desktop layout, display properties, and keyboard shortcuts are initialized out of a pure Lua scripting layer. This completely replaces standard rigid compositor syntax, rendering a highly reactive graphical workspace directly on top of **UWSM** (Universal Wayland Session Manager) for proper systemd user session tracking.

### 2. Dynamic Wallpaper-Driven Theming (Matugen + swww)
The environment features automated graphical skinning out of the box. Using `swww` for smooth canvas transitions, a daemon monitors wallpaper state. When a background changes, **Matugen** executes a real-time extraction matrix to re-skin the UI accents and terminal panels live.

### 3. Integrated Local AI Stack (Vulkan Accelerated)
The platform houses an on-demand, local AI inference framework. By injecting the system variable `GGML_VULKAN = "1"`, the engine forces **Vulkan compute acceleration** out of your hardware, enabling local text and speech models to run directly on integrated **AMD Radeon (Vega 7) graphics** without requiring complex ROCm or Nvidia CUDA dependencies.
*   **Speech-to-Text Dictation**: Mapped directly to physical hardware toggles via `nerd-dictation` and `whisper.cpp`. It transcribes speech data on-the-fly and programmatically inputs text wherever your active cursor sits.
*   **Local LLM Infrastructure**: Native packages for `koboldcpp` and `lmstudio` are installed and ready to ingest `.gguf` weight directories.

### 4. Zero-Symlink Global Scripting Path
All personal utility scripts stored inside `Sol/scripts/` are natively recognized by the operating system path definitions. There are no manual symlinks or execution mappings required; any automation script tossed into this workspace becomes executable system-wide instantly.

### 5. Automated Data Containment & Trash Engine
System caches and transient working folders are monitored by rolling background systemd temporary rules. Inactive files sitting inside designated `volatile-drawer` directories are automatically purged every 7 days, preventing disk bloat during heavy building cycles.

---

## 🎨 Visual Geometry Baseline
*   **Sharp Matrix Geometry**: Rounding is locked to `0` for hard, 90-degree industrial edges.
*   **Neon Gradient Borders**: Active windows project a 45-degree shifting frame between Electric Blue and Dark Violet.
*   **High-Pass Frosted Blur**: Floating layers run a 3-pass hardware blur engine for clean desktop visual separation.

---

## 🎯 Production Tooling Inventory

| Category | Component Pack |
| :--- | :--- |
| **Core Utilities** | Ghostty Terminal, Yazi File Browser, Wofi Launcher, Zip/7z Matrix |
| **GUI Framework** | Brave Browser, Obsidian Knowledge Base, Vesktop (Discord+Vencord), OBS Studio |
| **System Diagnostics** | `amdgpu_top`, `vulkan-tools`, `glxinfo` |
| **Network & Security** | Tailscale Mesh VPN, Cloudflared Tunnels, DNSCrypt-Proxy (Encrypted Local DNS Resolver) |

---

## 🛠️ Rapid Installation Guide

To deploy this configuration mapping onto a fresh NixOS environment:

1. Clone this repository directly into your home space:
   ```bash
   git clone https://github.com ~/ovrOS
   ```
2. Scan and output your current hard drive's hardware mount profile over the placeholder:
   ```bash
   nixos-generate-config --show-hardware-config > ~/ovrOS/hardware-configuration.nix
   ```
3. Initialize the compilation rebuild trigger:
   ```bash
   cd ~/ovrOS && sudo nixos-rebuild switch --flake .#ovrOS
   ```
   
*Note: Large AI model weight data binaries (.gguf) must be downloaded manually into your user directories before dictation or local inference engines run.*
