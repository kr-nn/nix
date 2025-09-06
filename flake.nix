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
      system = "x86_64-linux";
      agenixPkg = { home.packages = [ agenix.packages.${system}.default ]; };
      standardOptions = { inherit system; config.allowUnfree = true; };
      libs = import ./libs/lib.nix { config = allPkgs.pkgs-unstable.config; lib = allPkgs.pkgs-unstable.lib; pkgs = allPkgs.pkgs-unstable; };
      allPkgs = {
        pkgs-vivaldi = import nixpkgs-vivaldi standardOptions;
        pkgs-signal = import nixpkgs-signal standardOptions;
        pkgs-unstable = import nixpkgs-unstable standardOptions;
        pkgs-bleeding = import nixpkgs-bleeding standardOptions;
        pkgs-stable = import nixpkgs-stable standardOptions;
      };
      hmprInputs = (with allPkgs.pkgs-unstable; [
        coreutils
        nix
        jq
        gum
      ]) ++ [ home-manager.packages.${system}.default ];
      hmprScript = allPkgs.pkgs-unstable.writeShellScriptBin "hmpr" (builtins.readFile ./home/scripts/hmpr);
      hmpr = allPkgs.pkgs-unstable.stdenvNoCC.mkDerivation {
        pname = "hmpr";
        version = "1.0";
        nativeBuildInputs = [ allPkgs.pkgs-unstable.makeWrapper ];
        buildInputs = [ allPkgs.pkgs-unstable.jq allPkgs.pkgs-unstable.gum allPkgs.pkgs-unstable.home-manager ];
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/bin
          cp ${hmprScript}/bin/hmpr $out/bin/hmpr
          wrapProgram $out/bin/hmpr --prefix PATH : ${allPkgs.pkgs-unstable.lib.makeBinPath hmprInputs}
        '';
      };
      commonHomeModules = [ ./home/options/dotfiles.nix { programs.home-manager.enable = true; } nixvim.homeManagerModules.nixvim ];
    in {

  # HOMES ========================================================================
    homeConfigurations = {
      "kyle" = home-manager.lib.homeManagerConfiguration {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit libs; inherit allPkgs; };
        modules = [
          # Required / dependencies
          ./home/usernames/kyle.nix
          ./home/themes/rockstar.nix
          stylix.homeModules.stylix
          agenix.homeManagerModules.default
          agenixPkg
          # terminal
          ./home/comp/git.nix
          ./home/comp/ssh.nix
          ./home/comp/minio.nix
          ./home/comp/neovim.nix
          ./home/comp/zshell.nix
          ./home/comp/agenix.nix
          # desktop
          ./home/comp/framework-theme.nix
          ./home/comp/packages-personal.nix
          ./home/comp/packages-plasma.nix
          ./home/comp/dotfiles-plasma.nix
          ./home/comp/touchegg.nix
          ./home/comp/ckb-next.nix
          ./home/comp/yakuake.nix
        ] ++ commonHomeModules;
      };
      krobinson = {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit libs; inherit allPkgs; };
        modules = [
          # Required / dependencies
          ./home/usernames/krobinson.nix
          agenix.homeManagerModules.default
          agenixPkg
          # terminal
          ./home/comp/git.nix
          ./home/comp/ssh.nix
          ./home/comp/minio.nix
          ./home/comp/neovim.nix
          ./home/comp/zshell.nix
          ./home/comp/agenix.nix
          # desktop
          ./home/comp/packages-gui.nix
          ./home/comp/packages-plasma.nix
          ./home/comp/dotfiles-plasma.nix
        ] ++ commonHomeModules;
      };
      lpa = {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit libs; inherit allPkgs; };
        modules = [
          # Required / dependencies
          ./home/usernames/lpa.nix
          agenix.homeManagerModules.default
          agenixPkg
          # terminal
          ./home/comp/git.nix
          ./home/comp/ssh.nix
          ./home/comp/minio.nix
          ./home/comp/neovim.nix
          ./home/comp/zshell.nix
          ./home/comp/agenix.nix
          # desktop
          ./home/comp/packages-gui.nix
          ./home/comp/packages-plasma.nix
          ./home/comp/dotfiles-plasma.nix
        ] ++ commonHomeModules;
      };
    };

  # PACKAGES / APPS =============================================================
    packages.${system}.hmpr = hmpr;
    apps.${system}.hmpr = {
      type = "app";
      program = "${hmpr}/bin/hmpr";
    };
  };
}
