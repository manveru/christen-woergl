{ sources ? import ./sources.nix }:
with {
  overlay = _: pkgs: {
    inherit (import sources.niv { }) niv;
    packages = pkgs.callPackages ./packages.nix { };
    euphenix = (import sources.euphenix { });
  };
};
import sources.nixpkgs {
  overlays = [ overlay ];
  config = { };
}
