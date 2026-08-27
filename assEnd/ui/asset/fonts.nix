{ pkgs, ... }:

{
  # ─── FONTCONFIG ─────────────────────────────────────────────
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Liberation Serif" "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Liberation Sans" "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Hack Nerd Font Mono" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" "Noto Emoji" "Twemoji" ];
    };
  };

  # ─── FONT PACKAGES ──────────────────────────────────────────
  home.packages = with pkgs; [
    # Nerd Fonts (programming)
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.cascadia-code
    nerd-fonts.iosevka
    nerd-fonts.nerd-fonts-symbols-only
    
    # System fonts
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    noto-fonts-emoji-blob
    
    # UI fonts
    inter
    font-awesome
    twemoji
    
    # Language-specific
    vazir-fonts  # Persian/Arabic
    
    # Additional useful fonts
    corefonts  # Microsoft core fonts (Arial, Times New Roman, etc.)
    dejavu_fonts
    ubuntu_font_family
  ];
}