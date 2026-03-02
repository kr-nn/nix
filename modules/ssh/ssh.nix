{ inputs, ... }:
let
  comp = "ssh";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    home.file = {
      "${config.home.homeDirectory}/.oh-my-zsh/custom/plugins/zsh-ssh".source = pkgs.fetchgit {
        url = "https://github.com/kr-nn/zsh-ssh";
        rev = "6e78c0841c078eccd0f1293bd04f7df3a50be3cf";
        sha256 = "sha256-cUTMQDSIEM0VnSwhuoq2Adlve7OhGvW+41O/i8iw8bY=";
      };
    };
    age.secrets.id = {
      path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      file = ./id_ed25519.age;
    };
    age.secrets.sshconfig = {
      path = "${config.home.homeDirectory}/.ssh/config";
      file = ./sshconfig.age;
    };
    systemd.user.services.agenix.Unit.X-restart-Triggers = [
        config.age.secrets.id.path
        config.age.secrets.sshconfig.path
    ];
  };
}
