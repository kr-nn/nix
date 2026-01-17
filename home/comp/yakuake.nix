{ config, pkgs, libs, ... }:
{
  home.file = {
    "${config.home.homeDirectory}/.config/autostart/yakuake.desktop".text = libs.mkDesktopFile { env = ""; pkg = pkgs.kdePackages.yakuake; execArgs = "";};
  };
  home.dotfiles = {
    "${config.home.homeDirectory}/.config/yakuakerc" = {
      source = ../dotfiles/yakuakerc;
      mode = "600";
    };
  };
}
