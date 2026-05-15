{ config, ... }:
{

  age.secrets.lpavpn.file = ../secrets/lpavpn.ovpn;
  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  #networking.networkmanager = {
  #  insertNameservers = [ "10.0.0.1" ];
  #};

  #systemd.services.zerotierone.wantedBy = lib.mkForce [];
  services.openvpn.servers = {
    lpavpn = { config = '' config ${ config.age.secrets.lpavpn.path } ''; };
  };

}
