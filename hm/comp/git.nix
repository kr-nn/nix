{ config, lib, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  age.secrets.git.file = ../secrets/git.age;
  age.secrets.git.path = "${homedir}/.git-credentials";
  programs.git = {
    enable = true;
    aliases = {
      "chop" = "!: git checkout && ${homedir}/.nix-profile/bin/git-chop";
    };
    userName = lib.mkDefault "kyle";
    userEmail = lib.mkDefault "kyle@nocturnalnerd.xyz";
    extraConfig = {
      credential.useHttpPath = "true";
      credential.helper = "!gitauth";
      safe.directory = "/etc/nixos";
    };
  };
}
