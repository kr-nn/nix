{ config, pkgs, libs, ... }:
{
  home.dotfiles = {
    "${config.home.homeDirectory}/.config/systemsettingsrc".source = ../dotfiles/systemsettingsrc;
    "${config.home.homeDirectory}/.config/kglobalshortcutsrc".source = ../dotfiles/kglobalshortcutsrc;
    "${config.home.homeDirectory}/.config/mimeapps.list".source = ../dotfiles/mimeapps.list;
    "${config.home.homeDirectory}/.config/khotkeysrc".source = ../dotfiles/khotkeysrc;
  };
}
