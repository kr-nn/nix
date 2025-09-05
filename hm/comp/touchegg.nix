{ config, ...}:
let
  homedir="${config.home.homeDirectory}";
in
{
  home.dotfiles = {
    "${homedir}/.config/touchegg/touchegg.conf".source = ./dotfiles/touchegg.conf;
    "${homedir}/.config/touchpadxlibinputrc".source = ./dotfiles/touchpadxlibinputrc;
  };
}
