{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ git ];
  age.secrets.git.file = ../secrets/git.age;
  age.secrets.git.path = "${config.home.homeDirectory}/.git-credentials";
  systemd.user.services.agenix.Unit.X-restart-Triggers = [ config.age.secrets.git.path ]; # agenix restart trigger

  programs.git = {
    enable = true;
    aliases = {
      "chop" = "!: git checkout && ${config.home.homeDirectory}/.nix-profile/bin/git-chop";
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
