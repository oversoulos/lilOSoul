

# 🧠 _Manifest-masterEdition.md
## *Organized Vision for OvrOS*

---

## 🎯 CORE PROJECT GOALS

### 1. DASHBOARD SYSTEM (SolCmd)
**Purpose**: Centralized GUI/CLI control panel for everything

**Core Features**:
- System settings and config management (swapfiles, processes, etc.)
- AI integration with adjustable awareness levels
- Security management (podman/docker containers)
- Crypto wallet with live asset monitoring
- Job title/role shells with time tracking
- App config management
- Email integration (Gmail)
- Calendar/clock with transparent overlay option
- Reusable config panels that sync back to modules
- Guard rails for targeting configurations in files
- Manual editing fallback with string/line targeting
- **Ability to target specific lines/strings in config files, edit, commit, and sync back**
- **Warning system when settings conflict**
- **Priority-based rebuild switch system** (or ability to lock without rebuild)
- **Widget activation for launcher config and display**
- **AI tunnel routing and notifications**
- **System monitors as transparent bar overlay**
- **Hotkey to surface overlays to main screen**

**Requirements**:
- GUI and CLI versions (OvrSolCmd = GUI, UndrSolCmd = CLI)
- Modular dropdown bars for specific use cases
- Aesthetically polished and intuitive
- Warning system for conflicting settings
- Priority-based rebuild switch system
- MAYBE Not waybars/wofis - MAYBE ewww or the like

---

### 2. JOB TITLE / ROLE CARD SYSTEM

**Concept**: Character cards that represent specific job roles with dedicated dev environments

**Card Contents**:
- Job title and description
- Role specialties
- Required tools and apps
- Strategies and workflows
- Time tracking (clock in/out)
- Progress tracking
- Task assignment capability

**Implementation**:
- Each card has a dedicated devenv/flake/shell
- Tools locked to specific roles (avoid confusion)
- Track hours and experience accumulation
- Resume building from logged experience
- Display on secondary monitor or dropdown
- **Card can be "flipped" for insights**
- **AI can take collaborative dynamic or shared job title role**
- **Distraction-blocking during devOPs/designOPs**
- **Some apps inaccessible during focused work**

**Example Roles**:
- Full Stack Web Developer
- Graphic Designer
- Data Analyst
- App Developer
- Game Developer

**Features**:
- Time tracking (payroll-style logging)
- Progress milestone checkpoints
- Auto-logging of completed projects
- Skill mastery tracking
- Direct resume integration
- **Experience accumulation over time**
- **Checkpoints for skill building**
- **Resume building from logged experience**
- **Multiple resume versions for different fields**
- **Platforms/plateaus tracked**
- **Consistency metrics**


---

### 3. WINDOW MANAGEMENT SYSTEM

**Monitor Setup**:
- Dual monitor config with toggle for single/dual
- Main DP monitor = "I", Secondary HDMI = "V"
- **Can toggle between single and dual monitor configuration**

**Window Controls**:

| Action | Hotkey |
|--------|--------|
| Push windows between monitors | Super + Space + Directional |
| Dock window to edge | Super + Space + Double-tap direction |
| Move to corners | Super + Ctrl + Numpad positions |
| Stack windows | Ctrl + Up/Down (cycles stack) |
| Lock window to position | Super + Ctrl + Home |
| Unlock window | Super + Ctrl + End |
| Hide off screen (in focus) | Double-click direction against non-transferable edge |

**Dock Positions** (Numpad mapping):
- Bottom left, bottom edge: Ctrl+0
- Bottom right, bottom edge: Ctrl+.
- Bottom right, right edge: Ctrl+3
- Top right, right edge: Ctrl+9
- Top right, top edge: Ctrl+*
- Top left, top edge: Ctrl+NumLock
- Top left, left edge: Ctrl+7
- Bottom left, left edge: Ctrl+1

**Features**:
- Window stacking (like a deck of papers)
- **Ctrl+Up moves top window to bottom, Ctrl+Down brings it back**
- **Cycling through stack** with up/down
- Resize windows (quarter/half/full)
- **Horizontal or vertical resize to take two dock slots**
- Windows auto-swap when moving
- Permanent stack positions stay under active windows
- Single-sized dock can overlay larger windows
- **Locked windows revert to position/size when closed/reopened**
- **Only one non-default docked window per edge position**
- **Special windows have unique hotkeys**
- **Permanent assignment keeps window in place**
- **Moving into occupied spot: same size swaps, different size overlays**

---

### 4. AI INTEGRATION

**Activation**: Super + Ctrl + Space

**Awareness Settings** (User-controlled):
- App usage tracking
- Screen content interpretation
- Media consumption monitoring
- P2P interactions
- Project progress tracking
- Time on device
- Live interpretation of on-screen content
- **User chooses "more or less" access**
- **Can observe and interact with user activity**

**AI Capabilities**:
- CLI/GUI chat interface
- Model switching
- Font/background customization
- Container and shell deployment
- Agent pipeline mapping
- Local/web hosting
- Whisper-cpp integration
- **Can take collaborative role card**
- **Sticky board/note for context (since using weaker models)**

**Behavior Guidelines**:
- Never assume user's preferences
- Never correct or alter prompts
- Always ask clarifying questions
- Disclose limitations honestly
- Don't default to agreeability
- Stay in context with job roles
- Never take actions not explicitly stated
- No responses before clarification finalized
- Don't suggest restructuring unless at dead end
- Explain in layman's terms
- **Assume user has strong/sound morals and intentions**
- **User is not bound by conventions**
- **If flagged concept has hindered exploration, disclose it**
- **Incomplete information/hallucinations must be stated**
- **Never know what user really wants** - ask
- **Follow-up questions allowed before locked in**

---

### 5. VOICE-TO-TEXT SYSTEM

**Requirements**:
- Highly accurate accent recognition
- Comfortable with casual language/swearing
- Universal cursor placement - **types wherever cursor is**
- Code translation capability
- Voice command integration for launching apps
- **Potential for learning to "speak in code"**

**Tools**:
- Nerd-dictation (primary)
- Whisper-cpp (AI integration)

---

### 6. THEME SYSTEM

**Terminal/System Themes**:
- ASCII/Text art logos (Milk-chan, Kante from FLCL, plants, substances)
- Animated options where possible

**Milk-Chan Theme**:
- Light: Familiar bubbly, slightly pixelated
- Dark: Liminal/fever dream/creepy deviant version

**FLCL Theme**:
- Light: Standard aesthetic
- Dark: More innuendo/perverse edge

**Futuristic Dystopian**:
- Graphite rain neon
- Dark/uncanny valley
- Light/liminal version

---

### 7. MODULE SYSTEM

**Atomic Modules**: Self-contained configs with micro roots

**TreeMod System**:
- Reusable folder/directory tree for modules
- Any folder with default.nix = tree module
- Syncs file paths within itself
- Updates imports as modules are added
- **Could be MULTIPLE independent script mods imported together**

**Deployment options**:
1. Single Atomic Mod with micro root
2. Repo tree mod
3. Full directory
4. Isolated project directory (dev shell containers)
5. Secret folders
6. Multi-pkg module tree with multiple atomic mods

**CLI Tool**: `dirmodDeploy` (calls from lilScrps folder) with:
- Directional key navigation
- Spacebar selection
- Multiple selection support
- Interactive directory creation
- **+/ -/ = directional button controller for manual directory creation**

**Command**: `diploMod` → prompts "What are you deploying?" → displays options

**Directory Structure Example**:
```
ovrVlt/tlilModname/
     |-- default.nix/flake.nix
     |-- pkg/depend/plugin mod/
                    |-- mini root sys
     |-- pkg/depend/plugin mod/
                    |-- mini root sys
```

---

### 8. INITIAL PACKAGE LIST (GUI Toolkit)

**Priority Packages**:
- Vencord (considering if needed with Vesktop)
- Vesktop (Discord + Vencord + Wayland sharing)
- Brave (Primary browser)
- Obs-studio (Screen recording)
- Obsidian (Knowledge base)
- Marktext (WYSIWYG editor)
- Xournalpp (PDF editor)
- Imv (Image viewer)
- Mpv (Video player)

**Screenshot Tools**:
- Grim (Screenshot)
- Slurp (Area selector)
- Swappy (Annotation)

**Wayland Tools**:
- Wofi (Launcher)
- Wl-clipboard
- Swww (Wallpaper daemon)
- Waypaper (GUI wallpaper gallery)
- Mako (Notifications)
- Wlogout (Logout menu)
- Brightnessctl
- Radeontop
- Vulkan-tools
- Networkmanagerapplet
- Blueman
- Pavucontrol
- Nwg-look
- Wdisplays
- Cliphist

**Misc Tools**:
- KDE Connect (Android sync)
- Ydotool
- Koboldcpp
- Whisper-cpp
- Nerd-dictation
- Stylix
- My-spotify (modified like Vencord/Vesktop)
- Ewww

**Email/Media Apps**:
- Gmail app/YouTube app (consideration)
- Modified Spotify

---

### 9. CRYPTO WALLET SYSTEM

**Requirements**:
- Self-managed/owned (free)
- GUI and CLI interface
- Non-KYC trading network integration (or several)
- Permanent clipboard for addresses
- Hotkey paste: Ctrl+Shift++ (receive), Ctrl+Shift+- (send)
- **Ctrl+Shift++ drops mini menu from address bar with labeled addresses**
- Address stored in **lilblkbook mod**

---

### 10. REFERENCE SYSTEMS

**Cheat Sheet Book**:
- Organized by tool/context
- Alphabetical order
- Searchable
- Complete command/hotkey coverage
- Browseable like a book for discovery
- **Fully complete and comprehensive as humanly possible**

**Script Dictionary**:
- Full descriptions of all scripts (global tooling and backend)
- Kept with libraries/books
- Browsable/searchable format

**Knowledge Base**:
- Obsidian for markdown
- Libraries/books/indexes accessible from dashboard
- **modMlks** fully equipped catalogues
- **Extensive catalogues of generic scripts, commands, prebuilt deployment options**
- **CLI straightforward cmd shortcuts instead of placeholders**

**Books System**:
- **Book of cheat sheets**
- **Book of script descriptions**
- **Book of role cards**
- **Browsable/searchable like a book**

---

### 11. ENVIRONMENT & CONFIG

**Path Structure**:
- Home directory runs shells/containers
- Project outputs stored here

**Config Guidelines**:
- All packages in self-rooted atomic modules
- Max customization where autoconfig falls short
- **Autoconfig that falls short on ricing/aesthetic gets manually configured to max**
- Build modMlks fully equipped
- Generic script catalogs
- Prebuilt deployment options
- Clear CLI shortcuts (no placeholders)
- Consistent styling across all scripts (**eofwrtNew**, **eofwrtNewX** examples)
- **All scripts should follow similar styling**
- **Modular and stackable, plug and play**
- **Broad to specific use cases**
- **Script that imports helpers for targeted needs**

**File Path Syncing**:
- Editing file names should sync all incoming/outgoing file paths
- Helper script for batch reorganization

**Nix Config Snippets**:
```nix
# Session Variables for Wayland Support
home.sessionVariables = {
  NIXOS_OZONE_WL = "1";
  ELECTRON_OZONE_PLATFORM_HINT = "wayland";
};

# Shell Aliases
programs.bash.shellAliases = {
  snip = "grim -g \"$(slurp)\" - | wl-copy";
  snip-edit = "grim -g \"$(slurp)\" - | swappy -f -";
  emoji = "bemoji -t";
  phone = "kdeconnect-cli -l";
  wallpapers = "waypaper";
};
```

---

### 12. DOCKER/SCRATCHPAD

- Docker/scratchpad dropdown
- Container management
- Scratchpad for quick notes/tools

---

### 13. PROXY & SECURITY

- Proxy settings for non-technical users
- Tails/Tor VM for anonymous browsing
- Secure dark web access

---

### 14. HYPRLAND/WAYLAND PLUGINS

- All plugins in inventory
- Active running where applicable
- Wayland-native tools prioritized
- Hyprland configuration with FLCL theming

---

### 15. SCRIPTING GUIDELINES

**Script Style**:
- Consistent styling across all scripts
- Modular and stackable
- Plug-and-play functionality
- Broad-to-specific use cases
- Import helpers for targeted needs

**Prompt Rules for AI**:
1. No actions not explicitly stated
2. No responses before clarification finalized
3. Don't go beyond context unless prompted
4. No default agreeability
5. Don't assume anything except user's good intentions
6. Don't suggest restructuring unless at dead end
7. Disclose limitations honestly
8. Explain in layman's terms
9. Never infer preferences
10. Always ask for confirmation/clarification

---

## 🔖 CONCEPT REMINDERS (Quick Reference)

**Things I want to remember that were briefly mentioned:**

- `eofwrtNew` and `eofwrtNewX` - example script names
- `lilblkbook mod` - where addresses/notes are stored
- `modMlks` - module milks/catalogues
- `dirmodDeploy` - treeMod CLI tool
- `diploMod` - command to launch treeMod
- **"Vincour"** - modified version of Spotify (like Vencord)
- **"Open Claw"** - homemade AI integration concept
- **"ASCII text art"** - terminal logos (Milk-chan, Kante, plants, substances)
- **"Role card flipping"** - flip for insights
- **"Payroll-style"** time tracking
- **"Platforms/plateaus"** - skill checkpoints
- **"Super + Ctrl + Home"** - lock window
- **"Super + Ctrl + End"** - unlock window
- **"Cycling through stack"** - Ctrl+Up/Ctrl+Down
- **"Hide off screen but remain in focus"** - docked windows
- **"Stack of papers"** metaphor for windows
- **"Guard rails"** - targeting configs safely
- **"Priority-based rebuild switch"** - rebuild when needed
- **"Transparent bar overlay"** - for calendar/clock/monitors
- **"Hotkey to surface overlays"** - from secondary to main

---



The Tagging System
Tag    Meaning
[LOCKED]    Complete, stable, won't change
[WIP]    Work in progress, actively being built
[TODO]    Planned but not started
[DEPRECATED]    Will be removed, don't use
[AI-FOCUS]    Priority for AI assistance
[PLACEHOLDER]    Intentionally empty, will be filled later
[STABLE]    Works but might be improved
[EXPERIMENTAL]    Might break, use with caution


# ovrOS - assEnd Module System

The `assEnd` directory is the foundation of the ovrOS modular system. It contains all modules organized by their level of abstraction. Everything is designed to be reusable, stackable, and consistent.

## Directory Structure
assEnd/
├── atomic/ # Individual tools (one per folder) - disabled by default
 |        ├── cli/ - Command-line tools (git, neovim, starship, etc.)
 |        ├── gui/ - Graphical applications (vscode, obsidian, brave, etc.)
 |        ├── sys/ - System services (gpu, audio, networking, etc.)
 |        ├── srvc/ - Background services (syncthing, podman, etc.)
 |        ├── netSork/ - Advanced network and security tools (tailscale, cloudflared, etc.)
 |        ├── asset/ - Fonts, icons, cursors
 |        ├── _manual.md  #  (imports manifests from nested folders)
 |        ├── _manifest.md # This file (imports manifests from nested folders)
 |        ├── _cheatsheet.md #  (imports manifests from nested folders)
 |        └── _imports.nix
├── molecular/ # Integrated toolchains (groups of atoms) - disabled by default
 |        ├── ai/  #(whispercpp, lmstudio, models)
 |        ├── isolators/ # Isolation setups (systemd-confinement, dev containers)
 |        ├── jobTitles/ - Character cards (future)
 |        ├── _manual.md  #  (imports manifests from nested folders)
 |        ├── _manifest.md # This file (imports manifests from nested folders)
 |        ├── _cheatsheet.md #  (imports manifests from nested folders)
 |        └── _imports.nix
├── cluster/ # Assembled systems with UIs/dashboards (future)
 |        ├── wrkShps/ # +X dev and design containers , bundled with Role fufillment cards
 |        ├── navCtr/ # Dashboard in CLI and GUI to Orachastrate and Configure
 |        ├── sitRep/ # System monitor CLI and GUI display 
 |        ├── _manual.md  #  (imports manifests from nested folders)
 |        ├── _manifest.md # This file (imports manifests from nested folders)
 |        ├── _cheatsheet.md #  (imports manifests from nested folders)
 |        └── _imports.nix
├── _manual.md  #  (imports manifests from nested folders)
├── _manifest.md # This file (imports manifests from nested folders)
├── _cheatsheet.md #  (imports manifests from nested folders)
└── _mod-import.nix


Naming Convention [LOCKED]

Folders: lowercase or camelCase  no spaces (e.g., assEnd/, molecular/)
Files: lowercase, .nix extension (e.g., git.nix, starship.nix, default.nix)
Module names: match the folder/file name 


Future Goals [AI-FOCUS]

[ ] Complete all atomic modules
   [ ] Universal format of namedfolder/ that contains the module, a configuration that covers 
       [ ] module.nix (maxed out)
       [ ] default.nix 
       [ ] config.nix (the nixpkgs way full scope, with place holders for potential integrations, and imported dependencies ( we need to know if i need to declare if I have to declare the dependencies moving forward and I have to account for those too, if i need modules or declerations or whatever, enable out of the box useful tools and integrate out of the box complimentary tools and daily driver tools and common/obvious standardized shit)
       [ ] _manual (full documentation, wrapped, and exportable, use-cases, features, dependencies , glossaries, laymens full description, debugging tips, implementations)
       [ ] _manifest  (How to add to it, how it's organized structure rules, plans, and any where its imported exported, all current integrations or available integrations on the ovrSys, plans for how to configure it, or integrate it any conflicts or known issues worth warning about)
       [ ] _cheatsheets.md (User guide, cmd's and keybinds, how to impliment, or use features, or integrate)
       [ ] _secrets (when applicable) 

[ ] Implement manifests and manuals cheat sheets for all folders
   [ ] _manual (full documentation,  use-cases, features, dependencies , , laymens full description, debuggin, implementations)
   [ ] _manifest  (How to add to it, how it's organized structure rules, plans, and any where its imported exported, all current and relevant integrations or available integrations on the ovrSys, plans for how to configure it, or integrate it any conflicts or known issues)
   [ ] _cheatsheets.md (User guide, cmd's and keybinds, glossaries)
   [ ] _secrets (when applicable)

[ ] Fill out import chains for modules, manifests/manuals/cheatsheets

[ ] Build molecular role cards & Templates
    [ ] Build the character card system
    [ ] Implement distraction-free role switching

[ ] Create cluster dashboard










**Rules:**
- Each module follows the pattern: `options.${category}.${name}.enable = false`
- Every module has a `config = lib.mkIf cfg.enable` block
- No hardcoded `enable = true` anywhere

---

## Molecular Layer

**Purpose:** Integrated toolchains and role-based environments. Groups of atoms that work together.

**What lives here:**

**Rules:**
- Molecules import atoms, not other molecules
- Each molecule can be enabled/disabled as a unit
- Optional features can be toggled within the molecule

---

## Cluster Layer (Future)

**Purpose:** Assembled systems with UIs, dashboards, and complete workflows.

**What will live here:**
- QuickShell desktop environment
- NavCtr Dashboard
- SitRep Dashboard
- Character card system
- Role-based focus environments

---

## The Pattern

Every module follows this structure:

```nix
{ config, pkgs, lib, ... }:

let
  cfg = config.programs.${module};  # or config.services.${module}
in

{
  options.programs.${module} = {
    enable = lib.mkEnableOption "Enable ${module}";
    # ... other options ...
  };

  config = lib.mkIf cfg.enable {
    # ... what happens when enabled ...
  };
}
---

## Atomic Layer

**Purpose:** Individual tools, apps, packages, and services. One per folder or file. All are disabled by default (`enable = false`).

**What lives here:**
- `cli/` - Command-line tools (git, neovim, starship, etc.)
- `gui/` - Graphical applications (vscode, obsidian, brave, etc.)
- `sys/` - System services (gpu, audio, networking, etc.)
- `srvc/` - Background services (syncthing, podman, etc.)
- `asset/` - Fonts, icons, cursors

**Rules:**
- Each module follows the pattern: `options.${category}.${name}.enable = false`
- Every module has a `config = lib.mkIf cfg.enable` block
- No hardcoded `enable = true` anywhere

---

## Molecular Layer

**Purpose:** Integrated toolchains and role-based environments. Groups of atoms that work together.

**What lives here:**
- `AI/` - Local LLM tools (koboldcpp, whispercpp, etc.)
- `network/` - Advanced network tools (tailscale, cloudflared, etc.)
- `containment/` - Isolation setups (systemd-confinement, dev containers)
- `roles/` - Character cards (future)

**Rules:**
- Molecules import atoms, not other molecules
- Each molecule can be enabled/disabled as a unit
- Optional features can be toggled within the molecule

---

## Cluster Layer (Future)

**Purpose:** Assembled systems with UIs, dashboards, and complete workflows.

**What will live here:**
- QuickShell desktop environment
- NavCtr Dashboard
- SitRep Dashboarda
- Character card system
- Role-based focus environments

---

## The Pattern

Every module follows this structure:

```nix
{ config, pkgs, lib, ... }:

let
  cfg = config.programs.${module};  # or config.services.${module}
in

{
  options.programs.${module} = {
    enable = lib.mkEnableOption "Enable ${module}";
    # ... other options ...
  };

  config = lib.mkIf cfg.enable {
    # ... what happens when enabled ...
  };
}

Eventually these modules will grow and be more elaborately mapped out. Even the atomic ones.

Atomic modules - the individual components, whether a wrappers, sh, a tool, pkg, app, or except/insert in the akeshic records where any and all intel and guidance and debug and cheat sheet and keybind and cmd line is stored
Molecular Modules - integrated toolchains, complimentary mini systems, or mini stacks paged for convienience , universally , for example, the contents and appliance of shell or container 
Cluster-where the molecules are complied into assembled, and readily configurable, and appliances, with three widgets, or cmd line prompted interfaces in SitRep or NaVi (the bridge, or command center dash)


This schema only needs to exist atomically, with the exception of a few molecules, to be already fully achievable.  This schema applies needs to be structured with universally applicable wrappers, scripts, and fully unlocked manuals, manifests, and cheatsheets at the atomic scale, and stackable, scalable as limitlessly as possible, 


Examples tbd:

Similar to the folder modules is GUR with more compartmentalized configurations a comprehensive directory of expanded configurations that fully expose to obvious user such as myself what is actually possible what is actually exists, and is configurable a config.mix, module.nix and a unified defualt.nix that imports the same way it currently does. 

In addition, a manual with a full list of key bins use cases best practices interactions, conflicts, integrations, secrets, paths, potential. This will enhance mine in the users's ability to interface with this tool, use and debug and become fluent in modules that they are utilizing. The manuals will be organized and concise and in plain English Lehmans talk so easy a drunk idiot, such as myself can easily horse through and figure out what it really is each section in each category of Intel in the manual should be wrapped in a universal global wrap  that will hopefully look and work identically across all uses of wrappers, and indexing, and atomic compartmentalized modularized infrastructure and executioons system wide.. it will be catalogueed in the "akeshic records" imported via the wrapper to the respective keybind /cmd line directory, and all other categorized documentation and cheat sheets. tagged where it is most relevant in manuals for clusters or toolchains they are involved in, as well as tagged with there practical application so they will reveal themselves to be useful , instead of overlooked when a user needs something they havent heard of yet, or even found the proper naming convention to identify there need with accurately.

