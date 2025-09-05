{ config, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  age.secrets.id.file = ../secrets/id_ed25519.age;
  age.secrets.sshconfig.file = ../secrets/sshconfig.age;
  age.secrets.id.path = "${homedir}/.ssh/id_ed25519";
  age.secrets.sshconfig.path = "${homedir}/.ssh/config";
}
