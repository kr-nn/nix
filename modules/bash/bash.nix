{ inputs, ... }:
let
  comp = "bash";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    programs.bash = {
      enable=true;
      historyFile = "${config.xdg.dataHome}/bash/bash_history";
      initContent = ''
        ### systemd one-time triggers
        systemctl restart --user agenix
      ''; # TODO: The systemd trigger is to fix an issue with secret deployment, move to secretsInitializer.nix module
    };
  };
}
