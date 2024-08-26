{ ... }:
{

  networking.networkmanager = {
    insertNameservers = [ "10.0.0.1" ]; # manually set dns server to opnsense when on zerotier network
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = ["d3ecf5726de45d67"]; # This network can only manually join devices to the network
  };

}
