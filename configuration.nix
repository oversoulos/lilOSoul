{ config, pkgs, lib, username, hostname, ... }: {
  imports = [
    ./assEnd/ui/hyprland/default.nix
    ./assEnd/ui/dms-shell/default.nix
    ./assEnd/ui/asset/fonts.nix
    ./assEnd/ui/asset/cursors.nix
    ./assEnd/ui/asset/icons.nix
    ./assEnd/cli/default.nix
    ./assEnd/srvc/default.nix
    ./assEnd/sys/default.nix
  ];

  # ═══════════════════════════════════════════════════════
  # 🟢 AMD GPU GRAPHICS ACCELERATION Matrix
  # ═══════════════════════════════════════════════════════
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ 
      mesa
      vulkan-radeon
      amdvlk
    ];
  };

  # ═══════════════════════════════════════════════════════
  # 🟢 AUDIO CORE PIPEWIRE
  # ═══════════════════════════════════════════════════════
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  security.rtkit.enable = true;

  # ═══════════════════════════════════════════════════════
  # 🟢 DISPLAY MANAGER + UWSM INTEGRATION PIPELINE
  # ═══════════════════════════════════════════════════════
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "hyprland-uwsm"; # Explicitly routes through systemd session logic
    autoLogin = {
      enable = true;
      user = username;
    };
  };

  # ═══════════════════════════════════════════════════════
  # 🟢 PROFILE USER MANAGEMENT
  # ═══════════════════════════════════════════════════════
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    initialPassword = "4713";
    home = "/home/${username}";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "podman" "corectrl" "input" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [ 
    wget 
    curl 
    tree 
    jq 
    p7zip
    usbutils
    pciutils
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "quiet" "splash" ];

  networking.hostName = hostname;  # "ovrOS"
  networking.networkmanager.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
  };
  
  system.stateVersion = "26.05";
}
