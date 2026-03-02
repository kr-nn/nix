{ inputs, ... }:
let
  comp = "framework";
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }: {
    home.file = {
      "${config.home.homeDirectory}/.config/ksplashrc".text = "
        [KSplash]
        Theme=FrameWorkx200";

      "${config.home.homeDirectory}/.local/share/plasma/look-and-feel".source = pkgs.fetchgit {
        url = "https://github.com/kr-nn/Frame.Work_SplashScreen-KDE"; # Stolen from https://github.com/NL-TCH/Frame.Work_SplashScreen-KDE 
        rev = "87e4c601fb6eedceb92a127f96ff50cc836883bb";                          # Credit to their Awesome work
        sha256 = "1vnpvsa47a5vxr044r4zladz660xz867kc518j298l940s39s1lk";
      };
    };
  };
}
