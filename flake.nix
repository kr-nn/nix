{
  description = "Personal Systems";

  inputs = {

    # NIXPKGS
    nixpkgs-sorin.url = "github:nixos/nixpkgs/nixos-25.05";

    # HARDWARE
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Stylix
    stylix.url = "github:nix-community/stylix/release-25.05";

  };

  outputs = { self, nixpkgs-sorin, stylix, nixos-hardware, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      revision = if self ? rev then self.rev else self.dirtyRev;
      commonModules = [ ./hosts/common.nix { system.configurationRevision = revision; } ];
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
       ./hosts/_mods/plasma.nix
       ./hosts/_mods/syncthing.nix
       ./hosts/_mods/zerotier.nix
       #./hosts/_mods/displaylink.nix # not using displaylink right now, needs to get a new zip file anyway
       nixos-hardware.nixosModules.framework-13-7040-amd stylix.nixosModules.stylix ] ++ commonModules;
    };
  };
}
