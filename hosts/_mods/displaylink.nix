{ pkgs, ... }:
{
  displaylink = pkgs.fetchurl {
    url = "https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip";
    sha256 = "05m8vm6i9pc9pmvar021lw3ls60inlmq92nling0vj28skm55i92";
  };

  services.xserver = {
    videoDrivers = [ "displaylink" "modesetting" ];
  };
}
