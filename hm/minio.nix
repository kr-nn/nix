{ config, ... }:
let
  homedir="${config.home.homeDirectory}";
in
{
  age.secrets.minio.file = ../secrets/minioclientconfig.age;
  age.secrets.minio.path = "${homedir}/.mc/config.json";
}
