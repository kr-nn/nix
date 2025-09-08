{ config, pkgs, libs, ... }:
{
  programs.plasma = {
    input.touchpads = [
      {
        disableWhileTyping = true;
        enable = true;
        name = "PIXA3854:00 093A:0274 Touchpad";
        naturalScroll = true;
        productId = "0274";
        vendorId = "093a";
      }
    ];
  };
  #home.dotfiles = {
  #  "${config.home.homeDirectory}/.config/systemsettingsrc".source = ../dotfiles/systemsettingsrc;
  #  "${config.home.homeDirectory}/.config/kglobalshortcutsrc".source = ../dotfiles/kglobalshortcutsrc;
  #  "${config.home.homeDirectory}/.config/mimeapps.list".source = ../dotfiles/mimeapps.list;
  #  "${config.home.homeDirectory}/.config/khotkeysrc".source = ../dotfiles/khotkeysrc;
  #};
}
