{
  description = "NIX";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = nativeInputs: let inputs = nativeInputs.omniflake.flakes // nativeInputs ; in
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
      specialArgs = {
          mylib = import ./libs/lib.nix { lib = inputs.nixpkgs.lib; };
          mvpkgs = inputs.nixpkgs-multiverse.multiverse.x86_64-linux;
        };
    } (
    inputs.import-tree [
      inputs.home-manager.flakeModules.home-manager               # Import home-manager flake-parts module
      (inputs.import-tree.matchNot ''.*/secrets\.nix'' ./modules) # Import everything except secrets.nix
    ]
  );
}
