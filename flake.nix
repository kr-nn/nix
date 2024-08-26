{
  description = "Personal Systems";

  inputs = {

    # NIXPKGS
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";

    # HARDWARE
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Stylix
    stylix.url = "github:danth/stylix";

  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, nixpkgs-bleeding, stylix, nixos-hardware, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
      pkgs-bleeding = import nixpkgs-bleeding {inherit system; config.allowUnfree = true; };
    in {
  # NIXOS ========================================================================

    # Framework laptop
    nixosConfigurations."sorin" = nixpkgs-stable.lib.nixosSystem {
     inherit system;
     specialArgs = { inherit pkgs-unstable; inherit pkgs-bleeding; };
     modules = [
       ./hosts/sorin/configuration.nix
       nixos-hardware.nixosModules.framework-13-7040-amd
       stylix.nixosModules.stylix
     ];
    };

  };
}
