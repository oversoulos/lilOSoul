{
  description = "Isolated Dev Shell Template";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Add dev tools here (e.g. python3, nodejs, go)
        ];
        shellHook = ''
          echo "🚀 Entered custom template dev shell!"
        '';
      };
    };
}
