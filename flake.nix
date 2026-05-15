{
  description = "Personal Systems";

  inputs = {

    # NIXPKGS
    nixpkgs-sorin.url = "github:nixos/nixpkgs/nixos-unstable";

    # HARDWARE
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Stylix
    stylix.url = "github:nix-community/stylix/release-25.05";

    # xremap
    xremap.url = "github:xremap/nix-flake";

    # agenix
    agenix.url = "github:ryantm/agenix";

  };

  outputs = { self, nixpkgs-sorin, stylix, xremap, nixos-hardware, agenix, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      revision = if self ? rev then self.rev else self.dirtyRev;
      commonModules = [ ./hosts/common.nix xremap.nixosModules.default { system.configurationRevision = revision; } ];
    in {
  # NIXOS ========================================================================

    # Framework laptop
    nixosConfigurations."sorin" = nixpkgs-sorin.lib.nixosSystem {
     inherit system;
     modules = [
       # Core Modules
       ./hosts/sorin/configuration.nix
       ./hosts/sorin/hardware-configuration.nix

       # Addons
       ./hosts/_mods/gui-packages.nix
       ./hosts/_mods/plasma.nix
       ./hosts/_mods/xremap.nix
       ./hosts/_mods/syncthing.nix
       ./hosts/_mods/zerotier.nix
       ./hosts/_mods/docker.nix

       agenix.nixosModules.default
       nixos-hardware.nixosModules.framework-13-7040-amd /*stylix.nixosModules.stylix*/ ] ++ commonModules;
    };
  };
}
