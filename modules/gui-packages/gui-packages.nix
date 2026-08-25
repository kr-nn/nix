{ inputs, mypkgs, ... }:
let
  comp = "gui-packages";
in
{
  flake.homeModules.${comp} = { pkgs, ... }: {
    home.packages = with pkgs; [
      kdePackages.kate
      kdePackages.kompare
      kdePackages.merkuro
      kdePackages.plasma-browser-integration
      bitwarden-desktop
      simple-scan
      appimage-run
      steam-run
      deskflow

      mypkgs.pkgs-freerdp.freerdp
      mypkgs.pkgs-rustdesk.rustdesk
      mypkgs.pkgs-vivaldi.vivaldi
      mypkgs.pkgs-vivaldi.vivaldi-ffmpeg-codecs
      mypkgs.pkgs-vivaldi.widevine-cdm
    ];
  };
}
