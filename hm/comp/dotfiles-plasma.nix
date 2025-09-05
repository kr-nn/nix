{ config, pkgs, ... }:
let
  mkDesktopFile = { env, pkg, execArgs }: ''
    [Desktop Entry]
    Comment[en_CA]=${pkg.meta.mainProgram}
    Comment=${pkg.meta.description}
    Exec=env ${env} ${pkg}/bin/${pkg.meta.mainProgram} ${execArgs}
    Name[en_CA]=${pkg.meta.mainProgram}
    Name=${pkg.meta.mainProgram}
    TryExec=${pkg}/bin/${pkg.meta.mainProgram}
    Type=Application
  '';

  homedir="${config.home.homeDirectory}";
in
{
  home.file = {
    # the env fixes mismatched qt versions
    "${homedir}/.config/autostart/ckb-next.desktop".text = mkDesktopFile { env = "QT_PLUGIN_PATH="; pkg = pkgs.ckb-next; execArgs = "--background";};
    "${homedir}/.config/autostart/yakuake.desktop".text = mkDesktopFile { env = ""; pkg = pkgs.kdePackages.yakuake; execArgs = "";};
  };
  home.dotfiles = {
    "${homedir}/.config/yakuakerc".source = ./dotfiles/yakuakerc;
    "${homedir}/.config/systemsettingsrc".source = ./dotfiles/systemsettingsrc;
    "${homedir}/.config/kglobalshortcutsrc".source = ./dotfiles/kglobalshortcutsrc;
    "${homedir}/.config/mimeapps.list".source = ./dotfiles/mimeapps.list;
    "${homedir}/.config/khotkeysrc".source = ./dotfiles/khotkeysrc;
  };
}
