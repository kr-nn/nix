{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libsForQt5.kwallet-pam
  ];
}
