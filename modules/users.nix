{ inputs, mvpkgs, ... }:
let
  powerSet = inputs.nixpkgs.lib.foldl' (acc: x: acc ++ map (subset: subset ++ [ x ]) acc) [ [] ];
  mkHome = { name, addModules }: inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = mvpkgs.at "26.05";
    modules = [
      ({ config, ... }: {
        config = {
          _module.args.mv = config.multiverse.instance; # make mv available everywhere
          home.username = name;
          home.homeDirectory = "/home/${name}";
          home.stateVersion = "26.05";
          programs.home-manager.enable = true;
          nixpkgs.config.allowUnfree = true;
          multiverse = {
            enable = true;
            config.allowUnfree = true;
          };
        };
      })
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
    (profile: if profile.theme != "" # If theme is empty

      # eval non-gui profiles
      then {  ${inputs.nixpkgs.lib.removeSuffix "-" (profile.name + "-" + profile.theme + "-" + (inputs.nixpkgs.lib.join "-" profile.derivative)) } = mkGuiProfile { name=profile.name; theme=profile.theme; extraModules = map (profile: inputs.self.homeModules.${profile}) profile.derivative; }; }

      # eval gui profiles
      else {  ${inputs.nixpkgs.lib.removeSuffix "-" (profile.name + "-" + (inputs.nixpkgs.lib.join "-" profile.derivative)) } = mkProfile { name=profile.name; extraModules = map (profile: [ inputs.self.homeModules.${profile} ]) profile.derivative; }; }

    )
    (inputs.nixpkgs.lib.crossLists ( names: themes: derivatives: { name=names; theme=themes; derivative=derivatives; } ) [ names themes derivatives ] )
  );

}
