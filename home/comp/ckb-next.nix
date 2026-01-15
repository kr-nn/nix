{ config, pkgs, libs, ... }:
let
  pkg = pkgs.ckb-next.overrideAttrs (old: { cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DUSE_DBUS_MENU=0" ]; });
in
{
  home.file = {
    "${config.home.homeDirectory}/.config/autostart/ckb-next.desktop".text = libs.mkDesktopFile { env = "QT_PLUGIN_PATH="; inherit pkg; execArgs = "--background";};
  };
}

