{ inputs, ... }:
let
  comp = "nix";
in
{
  flake.homeModules.${comp} = { config, lib, pkgs, ... }: {
    nix.channels = {
      nixpkgs = inputs.nixpkgs;
      home-manager = inputs.home-manager;
      flake-parts = inputs.flake-parts;
    };
  };
}
