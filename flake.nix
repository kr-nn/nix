{
  description = "NIX";

  inputs = {

    # NIXPKGS
    ## packages
    nixpkgs-vivaldi.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-signal.url = "github:nixos/nixpkgs/master";
    ## Nixos
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-bleeding.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # HOME-MANAGER
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; };

    # fzf-preview
    fzf-preview = {
      url = "github:niksingh710/fzf-preview";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; };

    #Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; };

    # Stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; };

    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable"; }; };

  outputs = { nixpkgs-vivaldi, nixpkgs-unstable, nixpkgs-bleeding, nixpkgs-stable, nixpkgs-signal, agenix, stylix, nixvim, fzf-preview, home-manager, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      fzfpPkg = { home.packages = [ fzf-preview.packages.${system}.default ]; };
      agenixPkg = { home.packages = [ agenix.packages.${system}.default ]; };
      standardOptions = { inherit system; config.allowUnfree = true; };
      allPkgs = {
        pkgs-vivaldi = import nixpkgs-vivaldi standardOptions;
        pkgs-signal = import nixpkgs-signal standardOptions;
        pkgs-unstable = import nixpkgs-unstable standardOptions;
        pkgs-bleeding = import nixpkgs-bleeding standardOptions;
        pkgs-stable = import nixpkgs-stable standardOptions; };
      common-modules = [ nixvim.homeManagerModules.nixvim stylix.homeManagerModules.stylix agenix.homeManagerModules.default agenixPkg fzfpPkg ./modules/powerlevel10k.nix ];
      homeMaker = username: home-manager.lib.homeManagerConfiguration {
        pkgs = allPkgs.pkgs-unstable;
        extraSpecialArgs = { inherit allPkgs; };
        modules = [
          ./hm/${username}.nix
        ] ++ common-modules;
      };
    in {

  # HOMES ========================================================================

    homeConfigurations."kyle" = homeMaker "kyle";
    homeConfigurations."krobinson" = homeMaker "krobinson";

  };
}
