{ inputs, mv, ... }:
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
      (mv.at "56c02bc00adc").vivaldi
      (mv.at "56c02bc00adc").vivaldi-ffmpeg-codecs
      (mv.at "56c02bc00adc").widevine-cdm
    ];
  };
}
