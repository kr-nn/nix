{ config, lib, pkgs, ... }:


with lib;

let
  inherit (lib.hm) dag;
in {
# ==================================================================================
# custom options
# ==================================================================================
  options = {
    home.dotfiles = mkOption {
      type = types.attrsOf (types.submodule ({ name, config, ... }: {
        options = {
          source = mkOption {
            type = types.path;
            description = "Source file or directory to be copied.";
          };

          target = mkOption {
            type = types.str;
            default = name;
            description = "Target location for the file.";
          };
        };
      }));
      default = {};
      description = "Files to be copied instead of symlinked.";
    };
  };

  config = {
    home.activation.copyDotfiles = dag.entryAfter [ "writeBoundary" ] ''
      ${lib.concatStringsSep "\n" (mapAttrsToList (dst: src: ''
        install -D -m 644 ${lib.escapeShellArg src.source} ${lib.escapeShellArg dst}
      '') config.home.dotfiles)}
    '';
  };

# ==================================================================================
# helper functions
# ==================================================================================

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

