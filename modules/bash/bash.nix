{ inputs, ... }:
let
  comp = "bash";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    programs.bash = {
      enable=true;
      historyFile = "${config.xdg.dataHome}/bash/bash_history";
    };
  };
}
