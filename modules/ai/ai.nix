{ inputs, ... }:
let
  comp = "ai";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    home.packages = with pkgs; [ lmstudio ];
  };
}
