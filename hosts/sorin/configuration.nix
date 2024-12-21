{ lib, pkgs, pkgs-unstable, pkgs-bleeding, ... }:
let

  # Theme =====================================================
  wallpaper = ../../themes/media/framework.png;
  theme = {
    stylix.enable = true;
    stylix.image = wallpaper;
    stylix.fonts = { monospace.package = pkgs.fira-code-nerdfont; monospace.name = "nerdfonts-3.2.1"; };
    stylix.polarity = "dark";
  };
  lockscreenWallpaper = (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${wallpaper}
      type=image
    '');

  # OS things ==================================================
  main = lib.mkMerge [ theme {

    environment.systemPackages = with pkgs; [ vivaldi vivaldi-ffmpeg-codecs widevine-cdm lockscreenWallpaper fwupd framework-tool ];

    ## Bootloader ==============================================================
    boot.kernelPackages = pkgs.linuxPackages;

    ## Networking ==============================================================
    networking.hostName = "sorin";
    hardware.bluetooth.enable = true;

    ## Specific Drivers ========================================================
    services.fprintd.enable = false;
    hardware.ckb-next.enable = true;
    services.touchegg.enable = true;

    hardware.pulseaudio.enable = false;
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
