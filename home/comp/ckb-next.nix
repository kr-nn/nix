{ config, pkgs, libs, ... }:
{
  home.file = {
    "${config.home.homeDirectory}/.config/autostart/ckb-next.desktop".text = libs.mkDesktopFile { env = "QT_PLUGIN_PATH="; pkg = pkgs.ckb-next; execArgs = "--background";};
  };
}

