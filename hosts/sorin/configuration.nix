{ lib, pkgs, ... }:
let

  # Theme =====================================================
  wallpaper = ../../themes/media/framework.png;
  theme = {
    stylix.enable = true;
    stylix.image = wallpaper;
    stylix.fonts = { monospace.package = pkgs.nerd-fonts.fira-code; monospace.name = "nerdfonts-3.2.1"; };
    stylix.polarity = "dark";
  };
  lockscreenWallpaper = (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${wallpaper}
      type=image
    '');
  ckb-next = pkgs.ckb-next.overrideAttrs (old: { cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DUSE_DBUS_MENU=0" ]; });

  # OS things ==================================================
  main = lib.mkMerge [ /*theme*/ {

    environment.systemPackages = with pkgs; [ networkmanager-openvpn lockscreenWallpaper fwupd framework-tool ];

    ## Bootloader ==============================================================
    boot.kernelPackages = pkgs.linuxPackages;

    ## Networking ==============================================================
    networking.hostName = "sorin";
    hardware.bluetooth.enable = true;

    ## Specific Drivers ========================================================
    services.fprintd.enable = false;
    systemd.services.ckb-next.serviceConfig.ExecStart = lib.mkForce "${ckb-next}/bin/ckb-next-daemon --enable-experimental"; # Remove once this is merged into nixpkgs
    hardware.ckb-next = {
      enable = true;
      package = ckb-next;
    };
    services.touchegg.enable = true;
    # For printers and scanners
    services.avahi = { enable = true; openFirewall = true;};
    hardware.sane = { enable = true; openFirewall = true; extraBackends = [ pkgs.hplipWithPlugin pkgs.sane-airscan ]; };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    system.stateVersion = "23.11"; } ];
in
main
