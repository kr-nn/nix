{ config, lib, pkgs, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  age.identityPaths = [ "${homedir}/.ssh/id_ed25519" "${homedir}/.ssh/age.key" ];
  home.packages = with pkgs; [ age rbw pinentry-all ];

  programs.rbw = {
    enable = true;
    settings = {
      email = "kyle@nocturnalnerd.xyz";
      base_url = "https://vaultwarden.nocturnalnerd.xyz";
      pinentry = pkgs.pinentry-all;
      lock_timeout = 300;
    };
  };

  home.activation.secretsInit = lib.hm.dag.entryBetween ["reloadSystemd"] ["writeBoundary"] ''
    PATH="${config.home.path}/bin:$PATH:${pkgs.rbw}/bin"
    AGEPATH="/run/user/$UID/age.key"
    AGELINK="${homedir}/.ssh/age.key"
    [ -d ${homedir}/.ssh ] || mkdir -p ${homedir}/.ssh

    if ! [ -f $AGEPATH ] || [ -z "$(head -n 1 $AGEPATH)" ]; then
      echo $(rbw get "age key") > $AGEPATH
      rbw stop-agent
    fi
    if ! [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
      ln -s $AGEPATH $AGELINK
    else
      echo "Something strange happened"
      echo "check the age key"
    fi
  '';

  # Opening Shell =========================================================
  programs.zsh.initContent = ''
    ### Vaultwarden init ==================================================
    AGEPATH="/run/user/$UID/age.key"
    AGELINK="${homedir}/.ssh/age.key"
    if ! [ -f $AGEPATH ] || [ -z "$(head -n 1 $AGEPATH)" ]; then
      echo $(rbw get "age key") > $AGEPATH
      rbw stop-agent
    fi
    if ! [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
      ln -s $AGEPATH $AGELINK
    elif [ -L $AGELINK ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
      if [[ $(systemctl is-failed --user agenix) == "failed" ]] && [ -n "$(head -n 1 $AGEPATH)" ]; then
        systemctl restart --user agenix
      elif [[ $(systemctl is-failed --user agenix) == "failed" ]] && [ -z "$(head -n 1 $AGEPATH)" ]; then
        echo "Placing AgeKey failed"
      fi
    else
      echo "Something strange happened"
      echo "check the age key"
    fi
  '';
}
