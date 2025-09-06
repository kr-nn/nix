# These are packages for personal daily driver machines
# Highest level of packages
# includes ./packages-gui.nix & ./packages.nix

{ pkgs, allPkgs, ... }:
{
  imports = [ ./packages-gui.nix ];
  home.packages = with pkgs; [

    # docs
    obsidian
    onlyoffice-bin
    kdePackages.kate
    kdePackages.kompare

    # Social
    vesktop
    telegram-desktop
    allPkgs.pkgs-signal.signal-desktop

    # admin things
    bitwarden-desktop
    allPkgs.pkgs-stable.rustdesk
    remmina

    # Browser
    allPkgs.pkgs-vivaldi.vivaldi
    allPkgs.pkgs-vivaldi.vivaldi-ffmpeg-codecs
    allPkgs.pkgs-vivaldi.widevine-cdm

    # Entertainment
    mpv
    steam

  ];
}
