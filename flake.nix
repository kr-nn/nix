{
  description = "NIX";

  inputs = {

    flake-parts.url = "github:hercules-ci/flake-parts";

    ## generic channels
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    ## packages
    nixpkgs-vivaldi.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-signal.url = "github:nixos/nixpkgs/master";
    neix.url = "github:Hovirix/neix";

    # Modules
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    plasma = { url = "github:nix-community/plasma-manager"; inputs = { nixpkgs.follows = "nixpkgs-unstable"; home-manager.follows = "home-manager"; }; };

  };

  outputs = {
    flake-parts, nixpkgs-vivaldi, nixpkgs-signal,
    nixpkgs-unstable, nixpkgs-bleeding, nixpkgs-stable,
    agenix, stylix, nixvim, home-manager, plasma, neix,
    ... }@inputs : flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./homes/kyle.nix
        ./packages/hmpr.nix
      ];
  };
}
