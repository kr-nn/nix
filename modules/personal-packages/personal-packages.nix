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

      # Social
      vesktop
      telegram-desktop
      mypkgs.pkgs-signal.signal-desktop

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
