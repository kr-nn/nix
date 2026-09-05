{ pkgs, ... }: let
    lanRouting = pkgs.writeShellApplication {
      name = "lan-routing";

      runtimeInputs = with pkgs; [
        iproute2
        nix
        gawk
        coreutils
      ];

      text = ''
        priority=100
        config=/etc/lan-routing/subnets.nix
        state=/run/lan-routing.rules

        if test -f "$state"; then
          cat "$state" | while read -r destination; do
            ip rule delete priority "$priority" to "$destination" lookup main
          done
        fi

        rm -f "$state"

        interface=$(ip route show default | head -n 1 | awk '{print $5}')
        subnet=$(ip route show dev "$interface" scope link | head -n 1 | awk '{print $1}')

        if test -f "$config"; then
          destinations=$(nix eval --raw --impure --expr "
            let
              config = import $config;
            in
              builtins.concatStringsSep \" \" (config.\"$subnet\" or [ \"$subnet\" ])
          ")
        else
          destinations="$subnet"
        fi

        for destination in $destinations; do
          ip rule add priority "$priority" to "$destination" lookup main
          echo "$destination" >> "$state"
        done
      '';
    };
in
{
  systemd.services.lan-routing = {
    description = "Override overlay networks routing for local LANs";

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${lanRouting}/bin/lan-routing";
    };
  };

  systemd.timers.lan-routing = {
    wantedBy = [ "timers.target" ];

    timerConfig = {
      OnBootSec = "5s";
      OnUnitActiveSec = "10s";
    };
  };

  services.netbird = {
    enable = true;
    ui.enable = true;
  };

}


