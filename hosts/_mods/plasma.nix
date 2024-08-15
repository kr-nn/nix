{ ... }:
{

  services.displayManager.sddm.enable = true;
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  programs.kdeconnect.enable = true;
}
