{ config, lib, pkgs, ... }:
let
  homedir="${config.home.homeDirectory}";

  # Polarity
  polarityDark = { stylix.polarity = "dark"; };
  polarityLight = { stylix.polarity = "light"; };
  polarity = { stylix.polarity = "either"; };

  fontFiraMono = { stylix.fonts = { monospace.package = pkgs.nerd-fonts.fira-code; monospace.name = "nerdfonts-3.2.1"; }; };

  # Wallpapers/colorschemes =============================================

  genTheme = wallpaper: {
    stylix.image = wallpaper;
    stylix.polarity = lib.mkDefault "dark";
    home.file.".config/kscreenlockerrc".text = ''
      [Greeter]
      Wallpaper=org.kde.image
      WallpaperPlugin=org.kde.image
      Image=file://${wallpaper}
    '';
  };

  themeRockstar = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/ex/wallhaven-exvwko.jpg";
    sha256 = "sha256-rAmHsbchl/BCpj0hMts9rd4GM85OmwmP9RXirhAqH7U="; };

  themeParrotsec = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
    sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3"; };

  themeFloss = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/7p/wallhaven-7pz9v9.jpg";
    sha256 = "sha256-sqXEfndZiZ+Qt87D6NHj/0EAKXdUI+RsvlXckE6maMc="; };

  themePearls = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/gp/wallhaven-gpyq2e.png";
    sha256 = "sha256-d5uQ7BQ+tzFmx6shGpuMV6PBnUNfh7jbCRaaFxW8aNc="; };

  themeHearts = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/g8/wallhaven-g891mq.jpg";
    sha256 = "0kdzdny260klqz6mprns3641a59f652w9ppyy89dair07wb9a634"; };

  themeShego = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/l8/wallhaven-l8ogop.jpg";
    sha256 = "1w8w9l1fpd7y6svfvs6p49xy2kma0cdg9r8i4lfmh66535fvmy7d"; };

  # App skins ==========================================================
  ## Yakuake Skin
  yakuakeskinDark = { home.file."${homedir}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
    url = "https://github.com/kr-nn/noskin-yakuake";
    rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
    sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
    };
  };

  yakuakeskinLight = { home.file."${homedir}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
    url = "https://github.com/kr-nn/noskin-yakuake";
    rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
    sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
    };
  };

  yakuakeskinTransparent = { home.file."${homedir}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
    url = "https://github.com/kr-nn/noskin-yakuake";
    rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
    sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
    };
  };
in
{
}
