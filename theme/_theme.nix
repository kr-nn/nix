{ config, pkgs, lib, ... }:
let

  # Return AttrSet ======================================================
  main = {
    specialisation.Default-plasmax.configuration = lib.mkMerge [ emberRose Dark FiraMono { stylix.enable = true; }];
    specialisation.Default-plasmax-laptop.configuration = lib.mkMerge [ emberRose Dark FiraMono { stylix.enable = true; }];

    specialisation.Work-plasmax-laptop.configuration = lib.mkMerge [ parrotSec Dark FiraMono { stylix.enable = true; }];
    specialisation.Work-plasmax.configuration = lib.mkMerge [ parrotSec Dark FiraMono { stylix.enable = true; } ];

    stylix.image = lib.mkDefault nixos.stylix.image;
  };

  # Defaults ============================================================

  Dark = { stylix.polarity = "dark"; };
  Light = { stylix.polarity = "light"; };

  FiraMono = { stylix.fonts = { monospace.package = pkgs.fira-code-nerdfont; monospace.name = "nerdfonts-3.2.1"; }; };

  # Papers ==============================================================

  ## nixos
  nixos = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
    sha256 = "07zl1dlxqh9dav9pibnhr2x1llywwnyphmzcdqaby7dz5js184ly"; }; };

  ## rose embers
  emberRose = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/lq/wallhaven-lqmzkq.jpg";
    sha256 = "1fsja8fk86b8n971gmfw963f338s6z7yf5706a3sfn94ly22hw0b"; }; };

  ## Parrotsec green
  parrotSec = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
    sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3"; }; };

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
  #pinkPasties = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/g8/wallhaven-g891mq.jpg";
  #  sha256 = "0kdzdny260klqz6mprns3641a59f652w9ppyy89dair07wb9a634"; }; };

  ## tattood suicide girl in bathtub: Apr 24th 2024 vaneskka Gushwater
  #suicideGirl = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/m3/wallhaven-m362lm.jpg";
  #  sha256 = "0p2rls33jii573mzzc7ywkw0v0i0phkxfdxb3bmdh7glqavci7ba"; }; };

  ## A Very spicy Shego cosplay with green black and grey colorscheme
  #spicyShego = { stylix.image = pkgs.fetchurl {
  #  url = "https://w.wallhaven.cc/full/l8/wallhaven-l8ogop.jpg";
  #  sha256 = "1w8w9l1fpd7y6svfvs6p49xy2kma0cdg9r8i4lfmh66535fvmy7d"; }; };

# ====================================================================

  #formatValue = value:
  #  if builtins.isBool value
  #  then if value then "true" else "false"
  #  else builtins.toString value;

  #formatSection = path: data:
  #  let
  #    header = lib.concatStrings (map (p: "[${p}]") path);
  #    formatChild = name: formatLines (path ++ [ name ]);
  #    children = lib.mapAttrsToList formatChild data;
  #    partitioned = lib.partition builtins.isString children;
  #    directChildren = partitioned.right;
  #    indirectChildren = partitioned.wrong;
  #  in
  #    lib.optional (directChildren != []) header ++
  #    directChildren ++
  #    lib.flatten indirectChildren;

  #formatLines = path: data:
  #  if builtins.isAttrs data
  #  then
  #    formatSection path data
  #  else "${lib.last path}=${formatValue data}";

  #formatConfig = data:
  #  lib.concatStringsSep "\n" (formatLines [] data);

  #konsolerc = {
  #  "Desktop Entry".DefaultProfile="Stylix.profile";
  #};

  #konsoleProfile = {
  #  Appearance = {
  #    colorscheme = "Stylix";
  #  };
  #};

  #konsoleColorScheme = with config.lib.stylix.colors; {
  #  Background = { Color="${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";};
  #  BackgroundIntense = { Color = "${base03-rgb-r},${base03-rgb-g},${base03-rgb-b}";};
  #  Color0 = { Color = "${base00-rgb-r},${base00-rgb-g},${base00-rgb-b}";};
  #  Color0Intense = { Color = "${base03-rgb-r},${base03-rgb-g},${base03-rgb-b}";};
  #  Color1 = { Color = "${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}";};
  #  Color1Intense = { Color = "${base08-rgb-r},${base08-rgb-g},${base08-rgb-b}";};
  #  Color2 = { Color = "${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}";};
  #  Color2Intense = { Color = "${base0B-rgb-r},${base0B-rgb-g},${base0B-rgb-b}";};
  #  Color3 = { Color = "${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b}";};
  #  Color3Intense = { Color = "${base0A-rgb-r},${base0A-rgb-g},${base0A-rgb-b}";};
  #  Color4 = { Color = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";};
  #  Color4Intense = { Color = "${base0D-rgb-r},${base0D-rgb-g},${base0D-rgb-b}";};
  #  Color5 = { Color = "${base0E-rgb-r},${base0E-rgb-g},${base0E-rgb-b}";};
  #  Color5Intense = { Color = "${base0E-rgb-r},${base0E-rgb-g},${base0E-rgb-b}";};
  #  Color6 = { Color = "${base0C-rgb-r},${base0C-rgb-g},${base0C-rgb-b}";};
  #  Color6Intense = { Color = "${base0C-rgb-r},${base0C-rgb-g},${base0C-rgb-b}";};
  #  Color7 = { Color = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";};
  #  Color7Intense = { Color = "${base07-rgb-r},${base07-rgb-g},${base07-rgb-b}";};
  #  Foreground = { Color = "${base05-rgb-r},${base05-rgb-g},${base05-rgb-b}";};
  #  ForegroundIntense = { Color = "${base07-rgb-r},${base07-rgb-g},${base07-rgb-b}";};
  #  General = {
  #    Description="Stylix";
  #    Opactity=1;
  #    Wallpaper="";
  #  };
  #};

  #konsoleFiles = {
  #  home.file = {
  #    "${config.home.homeDirectory}/.local/share/konsole/Stylix.colorscheme".text = formatConfig konsoleColorScheme;
  #    "${config.home.homeDirectory}/.local/share/konsole/Stylix.Profile".text = formatConfig konsoleProfile;
  #    "${config.home.homeDirectory}/.config/konsolerc".text = formatConfig konsolerc;
  #  };
  #};

in
main
