with import ./nix/nixpkgs.nix;
pkgs.mkShell {
  buildInputs = [ yarn yarn2nix.yarn2nix ];
  node_modules = siteYarnPackages + "/node_modules";
  shellHook = ''
    unset preHook
    ${pkgs.yarn2nix.linkNodeModulesHook}
    export PATH="$PATH:./node_modules/.bin"
  '';
}
