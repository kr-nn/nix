{ config, ... }:
{
  age.secrets.id = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    file = ../secrets/id_ed25519.age;
  };
  age.secrets.sshconfig = {
    path = "${config.home.homeDirectory}/.ssh/config";
    file = ../secrets/sshconfig.age;
  };
  systemd.user.services.agenix.Unit.X-restart-Triggers = [
      config.age.secrets.id.path
      config.age.secrets.sshconfig.path
  ];
}
