{ inputs, mylib, ... }:
let
  comp = "ckb-next";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }:
    let
      pkg = pkgs.ckb-next.overrideAttrs (old: { cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DUSE_DBUS_MENU=0" ]; });
    in {
    home.file = {
      "${config.home.homeDirectory}/.config/autostart/ckb-next.desktop".text = mylib.mkDesktopFile { env = "QT_PLUGIN_PATH="; inherit pkg; execArgs = "--background";};
    };
  };
}
