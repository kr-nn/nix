{ ... }: {

  flake.homeModules.personal-packages = { config, pkgs, ... }: {

    multiverse.lock = ./multiverse.lock;
    home.packages = [

      # docs
      pkgs.obsidian
      pkgs.onlyoffice-desktopeditors

      # Social
      pkgs.vesktop
      pkgs.telegram-desktop
      config.multiverse.locked.signal-desktop

      # admin things
      pkgs.bitwarden-desktop

      # Entertainment
      pkgs.mpv
      pkgs.steam
      pkgs.prismlauncher
      pkgs.deluge

    ];

  };

}
