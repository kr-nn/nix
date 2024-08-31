{
  description = "NIX";

  inputs = {

    # NIXPKGS
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

  outputs = { nixpkgs-unstable, nixpkgs-bleeding, nixpkgs-stable, agenix, stylix, home-manager, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      agenixPkg = { home.packages = [ agenix.packages.${system}.default ]; };
      pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
      pkgs-bleeding = import nixpkgs-bleeding {inherit system; config.allowUnfree = true; };
      pkgs-stable = import nixpkgs-stable {inherit system; config.allowUnfree = true; };
      common-modules = [ stylix.homeManagerModules.stylix agenix.homeManagerModules.default agenixPkg ];
    in {

  # HOMES ========================================================================

    homeConfigurations."kyle" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;
      extraSpecialArgs = { inherit pkgs-stable; inherit pkgs-bleeding; };
      modules = [
        ./hm/kyle.nix
      ] ++ common-modules;
    };

    homeConfigurations."krobinson" = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs-unstable;
      extraSpecialArgs = { inherit pkgs-stable; inherit pkgs-bleeding; };
      modules = [
        ./hm/krobinson.nix
      ] ++ common-modules;
    };
  };
}
