{
  description = "Personal Systems";

  inputs = {

    # NIXPKGS
    nixpkgs-sorin.url = "github:nixos/nixpkgs/6aa7ad7"; # kernel issues: https://github.com/NixOS/nixpkgs/issues/575192
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs-sorin";
    stylix.url = "github:nix-community/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs-sorin";
    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs-sorin";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs-sorin";

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
    nixosConfigurations."sorin" = let inputs = self.inputs; in nixpkgs-sorin.lib.nixosSystem  {
     inherit system;
     specialArgs = { inherit inputs; };
     modules = [
       # Core Modules
       ./hosts/sorin/configuration.nix
       ./hosts/sorin/hardware-configuration.nix

       # Addons
       ./hosts/_mods/displaylink.nix
       ./hosts/_mods/gui-packages.nix
       ./hosts/_mods/plasma.nix
       ./hosts/_mods/xremap.nix
       ./hosts/_mods/netbird.nix
       ./hosts/_mods/docker.nix

       agenix.nixosModules.default
       nixos-hardware.nixosModules.framework-13-7040-amd /*stylix.nixosModules.stylix*/ ] ++ commonModules;
    };
  };
}
