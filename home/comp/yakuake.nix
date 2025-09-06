{ config, pkgs, ... }:
let
  mkDesktopFile = { env, pkg, execArgs }: ''
    [Desktop Entry]
    Comment[en_CA]=${pkg.meta.mainProgram}
    Comment=${pkg.meta.description}
    Exec=env ${env} ${pkg}/bin/${pkg.meta.mainProgram} ${execArgs}
    Name[en_CA]=${pkg.meta.mainProgram}
    Name=${pkg.meta.mainProgram}
    TryExec=${pkg}/bin/${pkg.meta.mainProgram}
    Type=Application
  '';

  homedir="${config.home.homeDirectory}";
in
{
  home.file = {
    "${homedir}/.config/autostart/yakuake.desktop".text = mkDesktopFile { env = ""; pkg = pkgs.kdePackages.yakuake; execArgs = "";};
  };
  home.dotfiles = {
    "${homedir}/.config/yakuakerc".source = ./dotfiles/yakuakerc;
  };
  home.packages = with pkgs; [ kdePackages.yakuake ];
}
