{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.vivaldi # vivaldi requires matching QT library of display manager, do not place in home-manager
    pkgs.vivaldi-ffmpeg-codecs
    pkgs.widevine-cdm
  ];
}
