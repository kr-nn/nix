{ ... }: {

  flake.homeModules.gui-packages = { pkgs, mv, ... }: {

    home.packages = with pkgs; [
      kdePackages.kate
      bitwarden-desktop
      simple-scan
      appimage-run
      steam-run
      deskflow

      (mv.version "rustdesk" "1.4.8")
      (mv.at "tip").vivaldi
      (mv.at "tip").vivaldi-ffmpeg-codecs
      (mv.at "tip").widevine-cdm
    ];

  };

}
