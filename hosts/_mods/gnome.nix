{ ... }:
{

  services.xserver = {
    displayManager.gdm.enable = true;
    enable = true;
    desktopManager.gnome.enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  #programs.kdeconnect.enable = true;
}
