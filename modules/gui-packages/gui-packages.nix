{ ... }: {

  flake.homeModules.gui-packages = { config, pkgs, ... }: {

    multiverse.lock = ./multiverse.lock;
    home.packages = [
      pkgs.kdePackages.kate
      pkgs.simple-scan
      pkgs.appimage-run
      pkgs.steam-run
      pkgs.deskflow

      config.multiverse.locked.rustdesk
      config.multiverse.locked.vivaldi
      config.multiverse.locked.vivaldi-ffmpeg-codecs
      config.multiverse.locked.widevine-cdm

    ];

  };

}
