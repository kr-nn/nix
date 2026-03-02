{ lib, ... }: {

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

}
