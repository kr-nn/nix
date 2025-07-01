{ pkgs, ... }:
{

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  programs.kdeconnect.enable = true;
}
