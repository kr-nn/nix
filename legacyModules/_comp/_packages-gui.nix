# These are packages that can be used in a work environment
# Second level of packages
# includes ./packages.nix

{ pkgs, allPkgs, ... }:
{
  imports = [ ./packages.nix ];
  home.packages = with pkgs; [
    kdePackages.kate
    kdePackages.merkuro
    kdePackages.plasma-browser-integration
    bitwarden-desktop
    simple-scan
    rustdesk
    remmina
    appimage-run
    steam-run

    #allPkgs.pkgs-vivaldi.vivaldi
    #allPkgs.pkgs-vivaldi.vivaldi-ffmpeg-codecs
    #allPkgs.pkgs-vivaldi.widevine-cdm
  ];
}
