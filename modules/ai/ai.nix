{ inputs, ... }:
let
  comp = "ai";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    home.packages = with pkgs; [ lmstudio inputs.llm.packages.x86_64-linux.zeroclaw ];
  };

  perSystem = { config, pkgs, ...}: {
    devShells.llm = pkgs.mkShell {
      packages = [
        inputs.llm.packages.x86_64-linux.zeroclaw
        pkgs.vllm
      ];
      shellHook = ''
      echo "success!"
      '';
    };
  };
}
