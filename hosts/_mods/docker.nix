{ ... }:
{

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.groups.docker.members = [ "kyle" ];

}
