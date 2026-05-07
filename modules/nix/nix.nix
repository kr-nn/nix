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
    nix.settings.trusted-substituters = [ "https://hydra.nixos.org/" "https://cache.saumon.network/proxmox-nixos" ];
    nix.settings.trusted-public-keys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" "cache.saumon.network:proxmox-nixos:D9RYSWpQQC/msZUWphOY2I5RLH5Dd6yQcaHIuug7dWM=" ];
  };
}
