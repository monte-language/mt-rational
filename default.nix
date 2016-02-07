{ system ? builtins.currentSystem, typhonPackage ? ~/typhon/default.nix }:
let
  nixpkgs = import <nixpkgs> { inherit system; };
  lib = nixpkgs.lib;
  typhon = nixpkgs.callPackage typhonPackage {};
  rational = typhon.montePackage rec {
    name = "rational";
    version = "0.0.0.0";
    entrypoints = [];
    # Cargo-culted.
    src = builtins.filterSource (path: type: lib.hasSuffix ".mt" path) ./.;
  };
  mtpkg = { monte-rational = rational; };
in
  mtpkg
