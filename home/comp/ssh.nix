{ config, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  age.secrets.id = {
    path = "${homedir}/.ssh/id_ed25519";
    file = ../secrets/id_ed25519.age;
  };
  age.secrets.sshconfig = {
    path = "${homedir}/.ssh/config";
    file = ../secrets/sshconfig.age;
  };
  systemd.user.services.agenix.Unit.X-restart-Triggers = [
      config.age.secrets.id.path
      config.age.secrets.sshconfig.path
  ];
}
