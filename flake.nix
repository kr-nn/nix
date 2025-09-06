{
  description = "NIX";

  inputs = {

    ## generic channels
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    ## packages
    nixpkgs-vivaldi.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-signal.url = "github:nixos/nixpkgs/master";

    # Modules
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    agenix = { url = "github:ryantm/agenix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    stylix = { url = "github:nix-community/stylix"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };

  };

  outputs = { nixpkgs-vivaldi, nixpkgs-unstable, nixpkgs-bleeding, nixpkgs-stable, nixpkgs-signal, agenix, stylix, nixvim, home-manager, ... }:

  # ARGS ========================================================================
    let
      lib = import ./lib/lib.nix;
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
          ./home/lib/dotfiles.nix
          { programs.home-manager.enable = true; }
          ./home/usernames/kyle.nix
          ./home/themes/rockstar.nix
          ./home/comp/git.nix
          ./home/comp/ssh.nix
          ./home/comp/minio.nix
          ./home/comp/neovim.nix
          ./home/comp/zshell.nix
          ./home/comp/agenix.nix
          ./home/comp/packages.nix
          ./home/comp/packages-daily-personal.nix
          ./home/comp/packages-plasma.nix
          ./home/comp/touchegg.nix
          ./home/comp/stylix-konsoleRc.nix
          ./home/comp/dotfiles-plasma.nix
          ./home/comp/framework-theme.nix
          ./home/comp/agenix.nix
          ./home/comp/yakuake.nix
          nixvim.homeManagerModules.nixvim
          stylix.homeModules.stylix
          agenix.homeManagerModules.default
          agenixPkg
        ];
      };
      krobinson = {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit allPkgs; };
        modules = [
          ./home/lib/dotfiles.nix
          { programs.home-manager.enable = true; }
          ./home/usernames/krobinson.nix
          ./home/themes/parrot.nix
          ./home/comp/git.nix
          ./home/comp/ssh.nix
          ./home/comp/minio.nix
          ./home/comp/neovim.nix
          ./home/comp/zshell.nix
          ./home/comp/agenix.nix
          ./home/comp/packages.nix
          ./home/comp/packages-daily-personal.nix
          ./home/comp/packages-plasma.nix
          ./home/comp/touchegg.nix
          ./home/comp/stylix-konsoleRc.nix
          ./home/comp/dotfiles-plasma.nix
          ./home/comp/framework-theme.nix
          ./home/comp/agenix.nix
          ./home/comp/yakuake.nix
          nixvim.homeManagerModules.nixvim
          stylix.homeModules.stylix
          agenix.homeManagerModules.default
          agenixPkg
        ];
      };
      lpa = {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit allPkgs; };
        modules = [
          ./home/lib/dotfiles.nix
          { programs.home-manager.enable = true; }
          ./home/usernames/lpa.nix
          ./home/themes/parrot.nix
          ./home/comp/git.nix
          ./home/comp/ssh.nix
          ./home/comp/minio.nix
          ./home/comp/neovim.nix
          ./home/comp/zshell.nix
          ./home/comp/agenix.nix
          ./home/comp/packages.nix
          ./home/comp/packages-daily-personal.nix
          ./home/comp/packages-plasma.nix
          ./home/comp/touchegg.nix
          ./home/comp/stylix-konsoleRc.nix
          ./home/comp/dotfiles-plasma.nix
          ./home/comp/framework-theme.nix
          ./home/comp/agenix.nix
          ./home/comp/yakuake.nix
          nixvim.homeManagerModules.nixvim
          stylix.homeModules.stylix
          agenix.homeManagerModules.default
          agenixPkg
        ];
      };
    };
  };
}
