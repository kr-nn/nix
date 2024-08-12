{ ... }: {

  imports = [
    ./_home.nix
 ];
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05";
}
