{ inputs, ... }:
let
  comp = "secrets";
  members = [ "kyle" "krobinson" ];
in {
  flake.homeModules.${comp} = { config, lib, pkgs, ... }:
    let
      vaultwardenUrl = "https://vaultwarden.nocturnalnerd.xyz";
      shellInit = ''
        ### Vaultwarden init ==================================================
        AGEPATH="/run/user/$UID/age.key"
        AGELINK="${config.home.homeDirectory}/.ssh/age.key"
        if ! [ -f $AGEPATH ] || [ -z "$(head -n 1 $AGEPATH)" ]; then
          echo $(rbw get "age key") > $AGEPATH
          rbw stop-agent
        fi
        if ! [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
          ln -s $AGEPATH $AGELINK
        elif [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then #BUG: duplicate check???
          if [[ $(systemctl is-failed --user agenix) == "failed" ]] && [ -n "$(head -n 1 $AGEPATH)" ]; then
            systemctl restart --user agenix
          elif [[ $(systemctl is-failed --user agenix) == "failed" ]] && [ -z "$(head -n 1 $AGEPATH)" ]; then
            echo "Placing AgeKey failed"
          fi
        else
          echo "Something strange happened"
          echo "check the age key"
        fi

        ### systemd one-time triggers
        systemctl restart --user agenix
      '';
      in {
    age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" "${config.home.homeDirectory}/.ssh/age.key" ];
    home.packages = with pkgs; [ age rbw pinentry-all ];

    programs.rbw = {
      enable = true;
      settings = {
        email = "kyle@nocturnalnerd.xyz";
        base_url = vaultwardenUrl;
        pinentry = pkgs.pinentry-all;
        lock_timeout = 300;
      };
    };

    home.activation.secretsInit = lib.hm.dag.entryBetween ["reloadSystemd"] ["writeBoundary"] ''
      PATH="${config.home.path}/bin:$PATH:${pkgs.rbw}/bin"
      AGEPATH="/run/user/$UID/age.key"
      AGELINK="${config.home.homeDirectory}/.ssh/age.key"
      [ -d ${config.home.homeDirectory}/.ssh ] || mkdir -p ${config.home.homeDirectory}/.ssh

      if ! [ -f $AGEPATH ] || [ -z "$(head -n 1 $AGEPATH)" ]; then
        echo $(rbw get "age key") > $AGEPATH
        rbw stop-agent
      fi
      if ! [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
        ln -s $AGEPATH $AGELINK
      elif [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
        echo "Secrets are fine. Doing nothing."
      else
        echo "Something strange happened"
        echo "check the age key"
      fi
    '';

    # Opening Shell =========================================================
    programs.zsh.initContent = shellInit;
    programs.bash.initExtra = shellInit;

  };
}
