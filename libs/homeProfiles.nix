{ pkgs, lib, flake-parts-lib }: {

  options = {

    flake = flake-parts-lib.mkSubmoduleOptions {

      homeProfile = lib.mkOption {
        default = { };
        description = ''
          homeProfiles is an abstract way to generate homeConfigurations to allow selectable modules in your home-manager configurations.
          Instead of defining a home configurations attrset you can generate many home-manager configurations based on rule-sets.
        '';
        type = lib.types.attrsOf (lib.types.submodule { options = {

          users = lib.mkOption {
            type = lib.types.attrsOf ( lib.types.submodule ( { name, ... }:{ options = {

              username = lib.mkOption {
                type = lib.types.str;
                default = name;
              };

              path = lib.mkOption {
                type = lib.types.str;
                default = "/home/${name}";
              };

              pkgs = lib.mkOption {
                type = lib.types.package;
                description = "The nixpkgs pkgs attribute set.";
              };

              state = lib.mkOption {
                type = lib.types.str;
                description = "The home.stateVersion";
              };

            };}));
          };

          component = lib.mkOption {
            type = lib.types.attrsOf ( lib.types.submodule ( { name, ... }:{ options = {

              component = lib.mkOption {
                type = lib.types.str;
                default = name;
              };

              members = lib.mkOption {
                type = lib.types.listOf lib.types;
                description = "The home.stateVersion";
              };

            };}));
          };

        };
        })
      };
    };
  };
}



#{ inputs, ... }: {
#  mkHome = { username, path, modules, pkgs }: inputs.home-manager.lib.homeManagerConfiguration {
#    inherit pkgs;
#    modules = [
#      {
#        config = {
#          home.username = username;
#          home.homeDirectory = path;
#          home.stateVersion = "25.05";
#          programs.home-manager.enable = true;
#        };
#      }
#    ] ++ modules;
#  };
#  compModules = 
#}


options.mod = mkOption {
  description = "submodule example";
  type = with types; submodule {
    options = {
      foo = mkOption {
        type = int;
      };
      bar = mkOption {
        type = str;
      };
    };
  };
};
