{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ /*deskflow*/ 24800 ];
  environment.systemPackages = [
    pkgs.vivaldi # vivaldi requires matching QT library of display manager, do not place in home-manager
    pkgs.vivaldi-ffmpeg-codecs
    pkgs.widevine-cdm
    pkgs.kdePackages.yakuake # yakuake requires compatible QT version
    pkgs.moonlight-qt # Codec Decode needs to match OS driver
  ];
}
