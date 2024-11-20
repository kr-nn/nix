{
  description = "NIX";

  inputs = {

    # NIXPKGS
    nixpkgs-signal.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # HOME-MANAGER
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    #Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = { nixpkgs-unstable, nixpkgs-bleeding, nixpkgs-stable, nixpkgs-signal, agenix, stylix, home-manager, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      agenixPkg = { home.packages = [ agenix.packages.${system}.default ]; };
      standardOptions = { inherit system; config.allowUnfree = true; };
      allPkgs = {
        pkgs-signal = import nixpkgs-signal standardOptions;
        pkgs-unstable = import nixpkgs-unstable standardOptions;
        pkgs-bleeding = import nixpkgs-bleeding standardOptions;
        pkgs-stable = import nixpkgs-stable standardOptions; };
      common-modules = [ stylix.homeManagerModules.stylix agenix.homeManagerModules.default agenixPkg ];
    in {

  # HOMES ========================================================================

    homeConfigurations."kyle" = home-manager.lib.homeManagerConfiguration {
      pkgs = allPkgs.pkgs-unstable;
      extraSpecialArgs = { inherit allPkgs; };
      modules = [
        ./hm/kyle.nix
      ] ++ common-modules;
    };

    homeConfigurations."krobinson" = home-manager.lib.homeManagerConfiguration {
      pkgs = allPkgs.pkgs-unstable;
      extraSpecialArgs = { inherit allPkgs; };
      modules = [
        ./hm/krobinson.nix
      ] ++ common-modules;
    };
  };
}
