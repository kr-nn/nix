{
  description = "NIX";

  inputs = {

    # NIXPKGS
    ## packages
    nixpkgs-vivaldi.url = "github:nixos/nixpkgs/nixos-25.05";

    nixpkgs-signal.url = "github:nixos/nixpkgs/master";

    ## Nixos
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

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
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

  };

  outputs = { nixpkgs-vivaldi, nixpkgs-unstable, nixpkgs-bleeding, nixpkgs-stable, nixpkgs-signal, agenix, stylix, nixvim, home-manager, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      agenixPkg = { home.packages = [ agenix.packages.${system}.default ]; };
      standardOptions = { inherit system; config.allowUnfree = true; };
      allPkgs = {
        pkgs-vivaldi = import nixpkgs-vivaldi standardOptions;
        pkgs-signal = import nixpkgs-signal standardOptions;
        pkgs-unstable = import nixpkgs-unstable standardOptions;
        pkgs-bleeding = import nixpkgs-bleeding standardOptions;
        pkgs-stable = import nixpkgs-stable standardOptions;
      };
    in {

  # HOMES ========================================================================
    homeConfigurations = {
      "kyle" = home-manager.lib.homeManagerConfiguration {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit allPkgs; };
        modules = [
          { stylix.enable = true; }
          ./hm/lib/dotfiles.nix
          ./hm/kyle.nix
          ./hm/git.nix
          ./hm/ssh.nix
          ./hm/minio.nix
          ./hm/neovim.nix
          ./hm/themes.nix
          ./hm/zshell.nix
          ./hm/secrets.nix
          ./hm/packages.nix
          ./hm/packages-gui.nix
          ./hm/packages-plasma.nix
          ./hm/touchegg.nix
          ./hm/activations.nix
          ./hm/environment.nix
          ./hm/dotfiles-plasma.nix
          ./hm/framework-theme.nix
          nixvim.homeManagerModules.nixvim
          stylix.homeModules.stylix
          agenix.homeManagerModules.default
          agenixPkg
        ];
      };
      #krobinson = {
      #  pkgs = allPkgs.pkgs-unstable;
      #  extraSpecialArgs = { inherit allPkgs; };
      #  modules = [
      #    ./hm/lib/dotfiles.nix
      #    ./hm/krobinson.nix
      #    nixvim.homeManagerModules.nixvim
      #    stylix.homeModules.stylix
      #    agenix.homeManagerModules.default
      #    agenixPkg
      #  ];
      #};
      #lpa = {
      #  pkgs = allPkgs.pkgs-unstable;
      #  extraSpecialArgs = { inherit allPkgs; };
      #  modules = [
      #    ./hm/lib/dotfiles.nix
      #    ./hm/lpa.nix
      #    nixvim.homeManagerModules.nixvim
      #    stylix.homeModules.stylix
      #    agenix.homeManagerModules.default
      #    agenixPkg
      #  ];
      #};
    };
  };
}
