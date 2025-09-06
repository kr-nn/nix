{ config, pkgs, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  home.packages = with pkgs; [ minio-client ];
  age.secrets.minio.file = ../secrets/minioclientconfig.age;
  age.secrets.minio.path = "${homedir}/.mc/config.json";

  # agenix restart trigger
  systemd.user.services.agenix.Unit.X-restart-Triggers = [ config.age.secrets.minio.path ];
}
