{ config, pkgs, ... }:
let
  homedir="${config.home.homeDirectory}";
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/ex/wallhaven-exvwko.jpg";
    sha256 = "sha256-rAmHsbchl/BCpj0hMts9rd4GM85OmwmP9RXirhAqH7U=";
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
  home.file."${homedir}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
    url = "https://github.com/kr-nn/noskin-yakuake";
    rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
    sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
  };

}
