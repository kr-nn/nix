{
  description = "NIX";

  inputs = {

    #Secrets management
    agenix.url = "github:ryantm/agenix";

    # NIXPKGS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Stylix
    stylix.url = "github:danth/stylix/release-24.05";

    # HOME-MANAGER
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
    };

  };

  outputs = { nixpkgs, agenix, stylix, home-manager, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

  # HOMES ========================================================================

    homeConfigurations."kyle" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./hm/kyle.nix
        stylix.homeManagerModules.stylix
        agenix.homeManagerModules.default
      ];
    };

    homeConfigurations."krobinson" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./hm/krobinson.nix
        stylix.homeManagerModules.stylix
        agenix.homeManagerModules.default
      ];
    };

  # SHELLS =======================================================================

    # TODO: turn this into an activation
    # deployment shell for home-manager (bootstraps master secret, then removes it post deployment)
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [
        pkgs.age
        pkgs.bitwarden-cli
        pkgs.home-manager
        pkgs.zsh
      ];
      shellHook = ''

        uid=$(id -u)
        bw config server https://vaultwarden.nocturnalnerd.xyz
        session=$(bw login --raw)
        export BW_SESSION=$session
        age_key=$(bw get password af9d248c-93e9-4de4-8e15-61b5801d326c)
        if [ $? -ne 0 ]; then
          echo "Failed to retrieve age key"
          exit 1
        fi

        echo "$age_key" > /run/user/$uid/age.key
        ln -s /run/user/$uid/ ~/.run

        home-manager switch

        if [ $? -ne 0 ]; then
          echo "home-manager switch failed"
          rm /run/user/$uid/age.key
          unlink ~/.run
          exit 1
        fi

        rm /run/user/$uid/age.key
        unlink ~/.run
        echo "success"
        exit
      '';
    };

  # END =========================================================================
  };
}
