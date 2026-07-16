{ inputs, ... }:
let
  system = "x86_64-linux";
  standardOptions = { inherit system; config.allowUnfree = true; };
  pkgs = import inputs.nixpkgs-unstable standardOptions;
  hmprInputs = (with pkgs; [
    coreutils
    nix
    jq
    gum
  ]) ++ [ inputs.home-manager.packages.${system}.default ];
  hmprScript = pkgs.writeShellScriptBin "hmpr" (builtins.readFile ../../home/scripts/hmpr);
  hmpr = pkgs.stdenvNoCC.mkDerivation {
    pname = "hmpr";
    version = "1.0";
    nativeBuildInputs = [ pkgs.makeWrapper ];
    buildInputs = [ pkgs.jq pkgs.fzf /*pkgs.gum*/ pkgs.home-manager ];
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cp ${hmprScript}/bin/hmpr $out/bin/hmpr
      wrapProgram $out/bin/hmpr --prefix PATH : ${pkgs.lib.makeBinPath hmprInputs}
    '';
  };
in
{
  flake.packages.${system}.hmpr = hmpr;
  flake.apps.${system}.hmpr = {
    type = "app";
    program = "${hmpr}/bin/hmpr";
  };
}
