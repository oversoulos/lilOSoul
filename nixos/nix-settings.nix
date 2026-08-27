{ config, pkgs, lib, ... }: {
  # ─── CORE SYSTEM INTERFACE OPTIONS ──────────────────────────
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  
  nixpkgs.config.allowUnfree = true;

  # Automated Nix Store Maintenance Engine
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # ─── EMERGENCY BOOT RECOVERY MATRIX ─────────────────────────
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10; # Guarantees 10 working rollback points in the boot menu
    };
    efi.canTouchEfiVariables = true;
  };

  # ─── ENVIRONMENT ARCHITECTURE RULES ──────────────────────────
  environment.sessionVariables = {
    # Dynamically makes all scripts inside your portable folder globally executable
    PATH = [ "$HOME/ovrOS/lilScrpts" ];
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # ─── THE ROLLING VOLATILE DRAWER CLEANER ─────────────────────
  systemd.tmpfiles.rules = [
    # Automatically purges inactive volatile cache files older than 7 days
    "e /home/*/ovrOS/modz/*/*/mod*/.config/volatile-drawer - - - 7d"
  ];
}
