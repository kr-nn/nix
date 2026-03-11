{ inputs, ... }:
let
  mkHome = { name, addModules }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
    modules = [
      {
        config = {
          home.username = name;
          home.homeDirectory = "/home/${name}";
          home.stateVersion = "25.11";
          programs.home-manager.enable = true;
        };
      }
    ] ++ addModules;
  };
in
{
  flake.homeConfigurations.kyle = mkHome { name="kyle"; addModules = [
      inputs.self.homeModules.ai
      inputs.self.homeModules.ckb-next
      inputs.self.homeModules.dotfiles
      inputs.self.homeModules.framework
      inputs.self.homeModules.git
      inputs.self.homeModules.personal-packages
      inputs.self.homeModules.gui-packages
      inputs.self.homeModules.plasma-packages
      inputs.self.homeModules.terminal-packages
      inputs.self.homeModules.minio
      inputs.self.homeModules.neovim
      inputs.self.homeModules.secrets
      inputs.self.homeModules.ssh
      inputs.self.homeModules.touchegg # replace with https://github.com/taj-ny/InputActions
      inputs.self.homeModules.yakuake
      inputs.self.homeModules.zshell
      inputs.self.homeModules.themes-rockstar

      # libraries
      inputs.nix-index.homeModules.default
      inputs.agenix.homeManagerModules.default
      inputs.plasma.homeModules.plasma-manager
      inputs.stylix.homeModules.stylix
      inputs.nixvim.homeModules.nixvim
    ];
  };
}
