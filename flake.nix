{
  description = "NIX";

  inputs = {

    ## Required
    nixpkgs.url = "github:nixos/nixpkgs/release-26.05";
    omniflake = {
      url = "github:fzakaria/omniflake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #multiverse.url = "github:fzakaria/nixpkgs-multiverse";
    #flake-parts.url = "github:hercules-ci/flake-parts";
    #import-tree.url = "github:vic/import-tree";

    ## packages
    #neix.url = "github:Hovirix/neix";

    ## Modules
    #nix-index = { url = "github:nix-community/nix-index-database"; inputs.nixpkgs.follows = "nixpkgs"; };
    #home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    #agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    #stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs"; };
    #nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs"; };
    #plasma = { url = "github:nix-community/plasma-manager"; inputs = { nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };

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
      #(inputs.import-tree ./modules)
      (inputs.import-tree.matchNot ''.*/secrets\.nix'' ./modules) # Import everything except secrets.nix
    ]
  );
}
