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

  # OS things ==================================================
  main = lib.mkMerge [ theme {

    environment.systemPackages = with pkgs; [ lockscreenWallpaper fwupd framework-tool ];

    ## Bootloader ==============================================================
    boot.kernelPackages = pkgs.linuxPackages;

    ## Networking ==============================================================
    networking.hostName = "sorin";
    hardware.bluetooth.enable = true;

    ## Specific Drivers ========================================================
    services.fprintd.enable = false;
    hardware.ckb-next.enable = true;
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
