{ config, pkgs, lib, ... }:
let

  # Return AttrSet ======================================================
  main = {
    stylix.enable = true;
    stylix.image = pinkPasties.stylix.image;
    stylix.fonts = FiraMono.stylix.fonts;
    stylix.polarity = "dark";
  };

  # Fonts ===============================================================
  FiraMono = { stylix.fonts = { monospace.package = pkgs.fira-code-nerdfont; monospace.name = "nerdfonts-3.2.1"; }; };

  # Papers ==============================================================

  ### nixos
  #nixos = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
  #  sha256 = "07zl1dlxqh9dav9pibnhr2x1llywwnyphmzcdqaby7dz5js184ly"; }; };

  ### rose embers
  #emberRose = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/lq/wallhaven-lqmzkq.jpg";
  #  sha256 = "1fsja8fk86b8n971gmfw963f338s6z7yf5706a3sfn94ly22hw0b"; }; };

  ### Parrotsec green
  #parrotSec = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
  #  sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3"; }; };

  # Spicy ===============================================================

  ### Degen weeb shit, pink, black and white
  #animeFeet = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/1p/wallhaven-1peygv.jpg";
  #  sha256 = "0zn89k6ipzk27vf11f9hqkzx0nk3b0nabs796mip2jf7d7cjmp1q"; }; };

  ## A dark greyscale image with a beautiful women adorning voluptuous breasts
  #classyTiddie = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/d6/wallhaven-d62llg.jpg";
  #  sha256 = "1yvp346s9bvqjwn9jviccml13qp3ny075w7xrnzba09xvlmpbv2m"; }; };

  ## Pink and Black pasties
  pinkPasties = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/g8/wallhaven-g891mq.jpg";
    sha256 = "0kdzdny260klqz6mprns3641a59f652w9ppyy89dair07wb9a634"; }; };

  ## tattood suicide girl in bathtub: Apr 24th 2024 vaneskka Gushwater
  #suicideGirl = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/m3/wallhaven-m362lm.jpg";
  #  sha256 = "0p2rls33jii573mzzc7ywkw0v0i0phkxfdxb3bmdh7glqavci7ba"; }; };

  # A Very spicy Shego cosplay with green black and grey colorscheme
  #spicyShego = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/l8/wallhaven-l8ogop.jpg";
  #  sha256 = "1w8w9l1fpd7y6svfvs6p49xy2kma0cdg9r8i4lfmh66535fvmy7d"; }; };

in
main
