
{ pkgs, ... }:
{
  # Voice-to-text, anywhere, like Gboard — nerd-dictation (light/offline
  # mode). wtype is what lets it actually type into whatever window is
  # focused; nerd-dictation on its own only transcribes.
  home.packages = with pkgs; [
    nerd-dictation
    wtype
  ];
}
