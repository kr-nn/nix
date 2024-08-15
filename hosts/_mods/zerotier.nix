{ ... }:
{

  networking.networkmanager = {
    insertNameservers = [ "10.0.0.1" ];
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = ["d3ecf5726de45d67"];
  };

}
