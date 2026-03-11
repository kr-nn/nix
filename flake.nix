{
  description = "NIX";

  inputs = {

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    ## generic channels
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    ## packages
    nixpkgs-vivaldi.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-signal.url = "github:nixos/nixpkgs/master";
    neix.url = "github:Hovirix/neix";

    # Modules
    nix-index = { url = "github:nix-community/nix-index-database"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    plasma = { url = "github:nix-community/plasma-manager"; inputs = { nixpkgs.follows = "nixpkgs-unstable"; home-manager.follows = "home-manager"; }; };

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; specialArgs = {
        mylib = import ./libs/lib.nix { lib = inputs.nixpkgs-unstable.lib; };
        mypkgs = {
          pkgs-vivaldi = import inputs.nixpkgs-vivaldi { system = "x86_64-linux"; config.allowUnfree = true; };
          pkgs-signal = import inputs.nixpkgs-signal { system = "x86_64-linux"; config.allowUnfree = true; };
          neixPkg = inputs.neix.packages.x86_64-linux.default;
        };
      };
    }
    (inputs.import-tree [
      inputs.home-manager.flakeModules.home-manager               # Import home-manager flake-parts module
      #(inputs.import-tree ./modules)
      (inputs.import-tree.matchNot ''.*/secrets\.nix'' ./modules) # Import everything except secrets.nix
    ]);
}
