{ inputs, ... }:
let
  powerSet = inputs.nixpkgs.lib.foldl' (acc: x: acc ++ map (subset: subset ++ [ x ]) acc) [ [] ];
  mkHome = { name, addModules }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.multiverse.multiverse.x86_64-linux.at "26.05";
    modules = [
      {
        config = {
          home.username = name;
          home.homeDirectory = "/home/${name}";
          home.stateVersion = "26.05";
          programs.home-manager.enable = true;
          nixpkgs.config.allowUnfree = true;
          multiverse.config.allowUnfree = true;
        };
      }
    ] ++ addModules;
  };
  mkProfile = { name, extraModules ? [] }: mkHome { name = name; addModules = [
      inputs.self.homeModules.dotfiles
      inputs.self.homeModules.secrets
      inputs.self.homeModules.zshell
      inputs.self.homeModules.neovim
      inputs.self.homeModules.ssh
      inputs.self.homeModules.git
      inputs.self.homeModules.terminal-packages
      inputs.nix-index.homeModules.default
      inputs.multiverse.homeManagerModules.default
      inputs.agenix.homeManagerModules.default
      inputs.nixvim.homeModules.nixvim
    ] ++ extraModules;
  };
  mkGuiProfile = { name, extraModules ? [], theme }: mkProfile { name = name; extraModules = [
      inputs.self.homeModules.yakuake
      inputs.self.homeModules.gui-packages
      inputs.self.homeModules.plasma-packages
      inputs.self.homeModules."themes-${theme}"
      inputs.plasma.homeModules.plasma-manager
      inputs.stylix.homeModules.stylix
    ] ++ extraModules;
  };
in
{
  flake.homeConfigurations = let
    names = [ "kyle" "root" "krobinson" "lpa" "user" ];
    themes = [ "parrotsec" "rockstar" "casino" "" ];
    derivatives = powerSet [ "framework" "minio" "personal-packages" "touchegg" "remmina" ]; # framework minio remmina touchegg personal-packages
  in
  inputs.nixpkgs.lib.mergeAttrsList
  (map
    (x: if x.theme != ""
      then {  ${inputs.nixpkgs.lib.removeSuffix "-" (x.name + "-" + x.theme + "-" + (inputs.nixpkgs.lib.join "-" x.derivative)) } = mkGuiProfile { name=x.name; theme=x.theme; extraModules = map (x: inputs.self.homeModules.${x}) x.derivative; }; }
      else {  ${inputs.nixpkgs.lib.removeSuffix "-" (x.name + "-" + (inputs.nixpkgs.lib.join "-" x.derivative)) } = mkProfile { name=x.name; extraModules = map (x: [ inputs.self.homeModules.${x} ]) x.derivative; }; }
    )
    (inputs.nixpkgs.lib.crossLists ( names: themes: derivatives: { name=names; theme=themes; derivative=derivatives; } ) [ names themes derivatives ] )
  );

}
#{
#  #flake.homeConfigurations.kyle-parrot = mkGuiProfile { name="kyle"; theme = inputs.self.homeModules.themes-parrotsec; addModules = [
#  #    inputs.self.homeModules.framework
#  #    inputs.self.homeModules.personal-packages
#  #    inputs.self.homeModules.minio
#  #    inputs.self.homeModules.touchegg # replace with https://github.com/taj-ny/InputActions
#  #    inputs.self.homeModules.remmina
#  #  ];
#  #};
#  #flake.homeConfigurations.kyle = mkHome { name="kyle"; addModules = [
#  #    inputs.self.homeModules.dotfiles
#  #    inputs.self.homeModules.framework
#  #    inputs.self.homeModules.git
#  #    inputs.self.homeModules.personal-packages
#  #    inputs.self.homeModules.gui-packages
#  #    inputs.self.homeModules.plasma-packages
#  #    inputs.self.homeModules.terminal-packages
#  #    inputs.self.homeModules.minio
#  #    inputs.self.homeModules.neovim
#  #    inputs.self.homeModules.secrets
#  #    inputs.self.homeModules.ssh
#  #    inputs.self.homeModules.touchegg # replace with https://github.com/taj-ny/InputActions
#  #    inputs.self.homeModules.yakuake
#  #    inputs.self.homeModules.zshell
#  #    inputs.self.homeModules.themes-rockstar
#  #    inputs.self.homeModules.remmina
#
#  #    # libraries
#  #    inputs.nix-index.homeModules.default
#  #    inputs.agenix.homeManagerModules.default
#  #    inputs.plasma.homeModules.plasma-manager
#  #    inputs.stylix.homeModules.stylix
#  #    inputs.nixvim.homeModules.nixvim
#  #  ];
#  #};
#}
