{ inputs, ... }:
let
  system = "x86_64-linux";
  agenixPkg = { home.packages = [ inputs.agenix.packages.${system}.default ]; };
  neixPkg = { home.packages = [ inputs.neix.packages.${system}.default ]; };
  standardOptions = { inherit system; config.allowUnfree = true; };
  libs = import ../../libs/lib.nix { config = allPkgs.pkgs-unstable.config; lib = allPkgs.pkgs-unstable.lib; pkgs = allPkgs.pkgs-unstable; };
  allPkgs = {
    pkgs-vivaldi = import inputs.nixpkgs-vivaldi standardOptions;
    pkgs-signal = import inputs.nixpkgs-signal standardOptions;
    pkgs-unstable = import inputs.nixpkgs-unstable standardOptions;
    pkgs-bleeding = import inputs.nixpkgs-bleeding standardOptions;
    pkgs-stable = import inputs.nixpkgs-stable standardOptions;
  };
  commonHomeModules = [ ../../home/options/dotfiles.nix { programs.home-manager.enable = true; } inputs.nixvim.homeModules.nixvim ];
in
{
  flake = {
    homeConfigurations."kyle" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = allPkgs.pkgs-unstable;
      extraSpecialArgs = { inherit libs; inherit allPkgs; };
      modules = [
        # Required / dependencies
        ../../home/usernames/kyle.nix
        ../../home/themes/rockstar.nix
        inputs.plasma.homeModules.plasma-manager
        inputs.stylix.homeModules.stylix
        inputs.agenix.homeManagerModules.default
        agenixPkg
        neixPkg
        # terminal
        ../../home/comp/git.nix
        ../../home/comp/ssh.nix
        ../../home/comp/minio.nix
        ../../home/comp/ai.nix
        ../../home/comp/neovim.nix
        ../../home/comp/zshell.nix
        ../../home/comp/agenix.nix
        # desktop
        ../../home/comp/framework-theme.nix
        ../../home/comp/packages-personal.nix
        ../../home/comp/packages-plasma.nix
        ../../home/comp/dotfiles-plasma.nix
        #../../home/comp/touchegg.nix
        ../../home/comp/ckb-next.nix
        ../../home/comp/yakuake.nix
      ] ++ commonHomeModules;
    };
  };
}
