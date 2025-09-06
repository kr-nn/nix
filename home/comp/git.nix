{ config, lib, pkgs, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  home.packages = with pkgs; [ git ];
  age.secrets.git.file = ../secrets/git.age;
  age.secrets.git.path = "${homedir}/.git-credentials";
  systemd.user.services.agenix.Unit.X-restart-Triggers = [ config.age.secrets.git.path ]; # agenix restart trigger

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
