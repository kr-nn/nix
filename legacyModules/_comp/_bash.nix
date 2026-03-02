{ config, }:
{
  programs.bash = { enable=true; historyFile = "${config.xdg.dataHome}/zsh/bash_history"; };
}
