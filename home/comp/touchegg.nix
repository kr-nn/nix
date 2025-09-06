{ config, ...}:
{
  home.dotfiles = {
    "${config.home.homeDirectory}/.config/touchegg/touchegg.conf".source = ../dotfiles/touchegg.conf;
    "${config.home.homeDirectory}/.config/touchpadxlibinputrc".source = ../dotfiles/touchpadxlibinputrc;
  };
}
