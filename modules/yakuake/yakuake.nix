{ inputs, ... }:
let
  comp = "yakuake";
in
{
  flake.homeModules.${comp} = { config, ... }: {
    home.dotfiles = {
      "${config.home.homeDirectory}/.config/yakuakerc" = {
        source = ./yakuakerc;
        mode = "600";
      };
    };
  };
}
