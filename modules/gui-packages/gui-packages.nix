{ inputs, mypkgs, mv, ... }:
let
  comp = "gui-packages";
in
{
  flake.homeModules.${comp} = { pkgs, ... }: {
    home.packages = with pkgs; [
      kdePackages.kate
      bitwarden-desktop
      simple-scan
      appimage-run
      steam-run
      deskflow

      (mv.version "rustdesk" "1.4.8")
      (mv.version "vivaldi" "56c02bc00adc")
      (mv.version "vivaldi-ffmpeg-codecs" "56c02bc00adc")
      (mv.version "widevine-cdm" "56c02bc00adc")
    ];
  };
}
