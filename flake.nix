{
  description = "Personal Systems";

  inputs = {

    # NIXPKGS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # HARDWARE
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # Stylix
    stylix.url = "github:danth/stylix";

  };

  outputs = { nixpkgs, stylix, nixos-hardware, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
    in {
  # NIXOS ========================================================================

    # Framework laptop
    nixosConfigurations."sorin" = nixpkgs.lib.nixosSystem {
     inherit system;
     modules = [
       ./hosts/sorin/configuration.nix
       nixos-hardware.nixosModules.framework-13-7040-amd
       stylix.nixosModules.stylix
     ];
    };

  };
}
