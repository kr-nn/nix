{ ... }: {

  flake.homeModules.personal-packages = { pkgs, mv, ... }: {

    home.packages = with pkgs; [

      # docs
      obsidian
      onlyoffice-desktopeditors

      # Social
      vesktop
      telegram-desktop
      (mv.version "signal-desktop" "8.18.0")

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
