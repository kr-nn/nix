{
  description = "NIX";

  inputs = {

    ## lib
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts = { url = "github:hercules-ci/flake-parts"; inputs.nixpkgs-lib.follows = "nixpkgs"; };
    import-tree = { url = "github:vic/import-tree"; }; # import tree has no inputs

    ## packages
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
    neix = { url = "github:Hovirix/neix"; inputs.nixpkgs.follows = "multiverse"; };
    nix-index = { url = "github:nix-community/nix-index-database"; inputs.nixpkgs.follows = "multiverse"; };

    ## Modules
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs"; };
    stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs"; };
    plasma = { url = "github:nix-community/plasma-manager"; inputs = { nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager"; }; };

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; specialArgs = {
        mvpkgs = inputs.multiverse.multiverse.x86_64-linux;
      };
    }
    (inputs.import-tree [
      inputs.home-manager.flakeModules.home-manager
        (inputs.import-tree.matchNot
          ''.*/secrets\.nix''
        ./modules )
    ]);
}
