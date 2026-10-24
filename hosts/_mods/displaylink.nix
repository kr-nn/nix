{ config, pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      displaylink = prev.displaylink.overrideAttrs {
        src = ../../assets/displaylink-620.zip;
      };
    })
  ];
  boot.extraModulePackages = [ config.boot.kernelPackages.evdi ] ;
  boot.initrd.kernelModules = [ "evdi" ];
  #boot.kernelPackages = inputs.nixpkgs-kernel.legacyPackages.x86_64-linux.linuxPackages_6_18; # kernel module issues: https://github.com/NixOS/nixpkgs/issues/575192

  environment.variables.KWIN_DRM_PREFER_COLOR_DEPTH = "24";
  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];
  systemd.services.dlm.wantedBy = [ "multi-user.target" ];
  environment.systemPackages = [ pkgs.displaylink ];

  ## fix order of operations
  #systemd.services.display-manager.after = [ "dlm.service" ];
  #systemd.services.dlm.before = [ "display-manager.service" ];
  #systemd.services.dlm.after = lib.mkForce [ ];
  #systemd.services.dlm.enable = true;

}
