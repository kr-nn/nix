{ pkgs, ... }:
{
  ## Syncthing config
  services.syncthing = {
    enable = true;
    user = "kyle";
    systemService = false;
    dataDir = "/home/kyle";
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
    settings = {
      options = {
        urAccepted = -1;
        relaysEnabled = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    syncthing
  ];
}
