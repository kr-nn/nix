{ inputs, ... }:
let
  comp = "ssh";
in
{
  flake.homeModules.${comp} = { config, ... }: {
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
