{ ... }: {
  imports = [
    ./nix-settings.nix
    # Individual system-level daemons hook into this imports array
  ];
}
