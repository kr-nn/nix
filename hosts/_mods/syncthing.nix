{ pkgs, ... }:
{
  ## Syncthing config
  services.syncthing = {
    enable = true;
    user = "kyle";
    systemService = false;
    dataDir = /home/kyle;
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
    settings = {
      options = {
        urAccepted = -1;
        relaysEnabled = false;
      };
      devices = {
        "vault".id = "SFVOF3W-MSEE5ME-XWB4Q7Q-EZMGMGG-7LVD6FW-LLINHCE-IJNQFU7-BRLJUAQ";
      };
      folders = {
        "/home/kyle/Knowledge".devices = ["vault"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    syncthing
  ];
}
