{ inputs, mypkgs, ... }:
let
  comp = "personal-packages";
in
{
  flake.homeModules.${comp} = { pkgs, ... }: {
    home.packages = with pkgs; [

      # docs
      obsidian
      onlyoffice-desktopeditors
      kdePackages.kate
      kdePackages.kompare

      # Social
      vesktop
      telegram-desktop
      mypkgs.pkgs-signal.signal-desktop

      # admin things
      bitwarden-desktop
      mypkgs.pkgs-rustdesk.rustdesk
      remmina

      # Browser
      mypkgs.pkgs-vivaldi.vivaldi
      mypkgs.pkgs-vivaldi.vivaldi-ffmpeg-codecs
      mypkgs.pkgs-vivaldi.widevine-cdm

      # Entertainment
      mpv
      steam

    ];
  };
}
