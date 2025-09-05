{ pkgs, allPkgs, ... }:
{
  home.packages = with pkgs; [

    # docs
    obsidian
    onlyoffice-bin
    kdePackages.kate
    kdePackages.kompare
    kdePackages.merkuro

    # System Packages
    kdePackages.partitionmanager

    # Social
    vesktop
    telegram-desktop
    allPkgs.pkgs-signal.signal-desktop

    # admin things
    bitwarden-desktop 
    allPkgs.pkgs-stable.rustdesk
    kdePackages.yakuake
    remmina

    # Fonts
    nerd-fonts.fira-code

    # Browser
    allPkgs.pkgs-vivaldi.vivaldi
    allPkgs.pkgs-vivaldi.vivaldi-ffmpeg-codecs
    allPkgs.pkgs-vivaldi.widevine-cdm

    # Entertainment
    mpv
    feishin
    steam

  ];
}
