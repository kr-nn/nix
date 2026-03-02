{ config, lib, pkgs, ... }:

with lib;

let
  inherit (lib.hm) dag;
in {
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

          mode = mkOption {
            type = types.str;
            default = "644";
            description = "The permissions assigned to the file";
          };
        };
      }));
      default = {};
      description = "Files to be copied instead of symlinked.";
    };
  };

  config = {
    home.activation.copyDotfiles = dag.entryAfter [ "writeBoundary" ] ''
      ${
        lib.concatStringsSep "\n"
          ( mapAttrsToList (
            dst: src: ''install -D -m ${lib.escapeShellArg src.mode} ${lib.escapeShellArg src.source} ${lib.escapeShellArg dst} '')
          config.home.dotfiles )
      }
    '';
  };
}

