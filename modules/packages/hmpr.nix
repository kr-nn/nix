{ inputs, ... }:
let
  system = "x86_64-linux";
  standardOptions = { inherit system; config.allowUnfree = true; };
  allPkgs = {
    pkgs-vivaldi = import inputs.nixpkgs-vivaldi standardOptions;
    pkgs-signal = import inputs.nixpkgs-signal standardOptions;
    pkgs-unstable = import inputs.nixpkgs-unstable standardOptions;
    pkgs-bleeding = import inputs.nixpkgs-bleeding standardOptions;
    pkgs-stable = import inputs.nixpkgs-stable standardOptions;
  };
  hmprInputs = (with allPkgs.pkgs-unstable; [
    coreutils
    nix
    jq
    gum
  ]) ++ [ inputs.home-manager.packages.${system}.default ];
  hmprScript = allPkgs.pkgs-unstable.writeShellScriptBin "hmpr" (builtins.readFile ../../home/scripts/hmpr);
  hmpr = allPkgs.pkgs-unstable.stdenvNoCC.mkDerivation {
    pname = "hmpr";
    version = "1.0";
    nativeBuildInputs = [ allPkgs.pkgs-unstable.makeWrapper ];
    buildInputs = [ allPkgs.pkgs-unstable.jq allPkgs.pkgs-unstable.gum allPkgs.pkgs-unstable.home-manager ];
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/bin
      cp ${hmprScript}/bin/hmpr $out/bin/hmpr
      wrapProgram $out/bin/hmpr --prefix PATH : ${allPkgs.pkgs-unstable.lib.makeBinPath hmprInputs}
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
