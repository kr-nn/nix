{
  description = "Personal Systems";

  inputs = {

    # NIXPKGS
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-stable-dis.url = "github:nixos/nixpkgs/249fbde2a178a2ea2638b65b9ecebd531b338cf9"; # working displaylink
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";

    # HARDWARE
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Stylix
    stylix.url = "github:danth/stylix/release-24.05";

  };

  outputs = { nixpkgs-stable, nixpkgs-stable-dis, nixpkgs-unstable, nixpkgs-bleeding, stylix, nixos-hardware, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {inherit system; config.allowUnfree = true; };
      pkgs-stable-dis = import nixpkgs-stable-dis {inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable {inherit system; config.allowUnfree = true; };
      pkgs-bleeding = import nixpkgs-bleeding {inherit system; config.allowUnfree = true; };
    in {
  # NIXOS ========================================================================

    # Framework laptop
    nixosConfigurations."sorin" = nixpkgs-stable-dis.lib.nixosSystem {
     inherit system;
     specialArgs = { inherit pkgs-unstable; inherit pkgs-bleeding; inherit pkgs-stable;};
     modules = [
       ./hosts/sorin/configuration.nix
       nixos-hardware.nixosModules.framework-13-7040-amd
       stylix.nixosModules.stylix
     ];
    };

  };
}
