{ inputs, ... }:
let
  comp = "touchegg";
in
{
  flake.homeModules.${comp} = { config, ...}: {
    home.dotfiles = {
      "${config.home.homeDirectory}/.config/touchegg/touchegg.conf".source = ./touchegg.conf;
      "${config.home.homeDirectory}/.config/touchpadxlibinputrc".source = ./touchpadxlibinputrc;
    };
  };
}
