{ ... }:
{

  networking.networkmanager = {
    insertNameservers = [ "10.0.0.1" ];
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "565799d8f6032b14" ]; # This network can only manually join devices to the network
  };

}
