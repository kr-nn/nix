{ ... }:
{
  imports = [
    ./_home.nix
  ];

  home.username = "krobinson";
  home.homeDirectory = "/home/krobinson";
  home.stateVersion = "24.05";

}
