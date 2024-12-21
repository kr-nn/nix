{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      displaylink = prev.displaylink.overrideAttrs {
        src = ../../assets/displaylink-580.zip;
      };
    })
  ];

  services.xserver = {
    videoDrivers = [ "displaylink" "modesetting" ];
  };

  environment.systemPackages = [
    pkgs.displaylink
  ];
}
