{ inputs, ... }:
let
  comp = "parrotsec";
in
{
  flake.homeModules."themes-${comp}" = { config, pkgs, ... }:
  let
    wallpaper = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
      sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3";
    };
  in
  {
    stylix.enable = true;
    stylix.image = wallpaper;
    stylix.polarity = "dark";
    stylix.fonts = {
      monospace.package = pkgs.nerd-fonts.fira-code;
      monospace.name = "nerdfonts-3.2.1";
    };

    # Screenlock
    home.file.".config/kscreenlockerrc".text = ''
      [Greeter]
      Wallpaper=org.kde.image
      WallpaperPlugin=org.kde.image
      Image=file://${wallpaper}
    '';

    # yakuake skin
    home.file."${config.home.homeDirectory}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
      url = "https://github.com/kr-nn/noskin-yakuake";
      rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
      sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
    };

  };
}
