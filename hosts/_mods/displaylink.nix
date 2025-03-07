{ lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      displaylink = prev.displaylink.overrideAttrs {
        src = ../../assets/displaylink-600.zip;
      };
    })
  ];

  services.xserver = {
    videoDrivers = [ "displaylink" "modesetting" ];
  };

  # fix order of operations
  systemd.services.display-manager.after = [ "dlm.service" ];
  systemd.services.dlm.before = [ "display-manager.service" ];
  systemd.services.dlm.after = lib.mkForce [ ];

  environment.systemPackages = [
    pkgs.displaylink
  ];
}
