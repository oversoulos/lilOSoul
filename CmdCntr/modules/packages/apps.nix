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
