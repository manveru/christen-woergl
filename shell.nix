with import ./nix { };
let
  nixpkgs-unstable = builtins.getFlake "github:nixos/nixpkgs/nixpkgs-unstable";
in
pkgs.mkShell {
  buildInputs = [ cacert niv euphenix.euphenix nixpkgs-unstable.legacyPackages.x86_64-linux.netlify-cli ];
  shellHook = ''
    unset preHook
  '';
}
