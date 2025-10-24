{ config, pkgs, libs, ... }:
{
  home.file = {
    "${config.home.homeDirectory}/.config/autostart/yakuake.desktop".text = libs.mkDesktopFile { env = ""; pkg = pkgs.kdePackages.yakuake; execArgs = "";};
  };
  home.dotfiles = {
    "${config.home.homeDirectory}/.config/yakuakerc".source = ../dotfiles/yakuakerc;
  };
  #home.packages = with pkgs; [ kdePackages.yakuake ]; # Yakuake depends on compatible QT version. Moved to nixos.
}
