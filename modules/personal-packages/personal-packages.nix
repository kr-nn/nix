{ ... }: {

  flake.homeModules.personal-packages = { pkgs, mv, ... }: {

    home.packages = with pkgs; [

      # docs
      obsidian
      onlyoffice-desktopeditors

      # Social
      vesktop
      telegram-desktop
      (mv.at "tip").signal-desktop

      # admin things
      bitwarden-desktop

      # Entertainment
      mpv
      steam
      prismlauncher
      deluge

    ];

  };

}
