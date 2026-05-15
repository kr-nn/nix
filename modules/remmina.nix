{ inputs, ... }:
let
  comp = "remmina";
  remmina-AAD = inputs.nixpkgs.legacyPackages.x86_64-linux.remmina.overrideAttrs (oldAttrs: rec {
    version = "09292ca323c7862684b1e675e384245ca192c5f2";
    src = inputs.nixpkgs.legacyPackages.x86_64-linux.pkgs.fetchFromGitLab {
      owner = "Remmina";
      repo = "remmina";
      rev = version;
      sha256 = "sha256-1ZKpgPYFJ8rUMVX4pEwbV74dxvUr7w46Ou/orLic2rk=";
    };

    # If you need to patch the source, add patches here
    # patches = [ ./path-to-your-patch.patch ];
  });

in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    home.packages = with pkgs; [ remmina-AAD ];
  };
}

