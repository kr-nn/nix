{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.powerlevel10k;
  unicodeSupportWarning = ''
    If you have issues check: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#icons-glyphs-or-powerline-symbols-dont-render
    Only use unicode icons if you know you have unicode support
    Ascii is in use by default for compatibility
  '';
  colorsWarning = ''
    Any number between 0 & 255.
    see color map by running:
    for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}''${(l:3::0:)i}%f " ''${''${(M)$((i%6)):#3}:+$'\n'}; done
  '';

  # Convert an option value to a string to be passed as argument to
  # powerlevel10k:
  valueToString = value:
    if builtins.isList value then
      builtins.concatStringsSep "," (builtins.map valueToString value)
    else if builtins.isAttrs value then
      valueToString
      (mapAttrsToList (key: val: "${valueToString key}=${valueToString val}")
        value)
    else
      builtins.toString value;

#  modulesArgument = optionalString (cfg.modules != null)
#    " -modules ${valueToString cfg.modules}";

#  modulesRightArgument = optionalString (cfg.modulesRight != null)
#    " -modules-right ${valueToString cfg.modulesRight}";

#  evalMode = cfg.modulesRight != null;

#  evalArgument = optionalString (evalMode) " -eval";

#  newlineArgument = optionalString cfg.newline " -newline";

#  pathAliasesArgument = optionalString (cfg.pathAliases != null)
#    " -path-aliases ${valueToString cfg.pathAliases}";

#  otherSettingPairArgument = name: value:
#    if value == true then " -${name}" else " -${name} ${valueToString value}";

#  otherSettingsArgument = optionalString (cfg.settings != { })
#    (concatStringsSep ""
#      (mapAttrsToList otherSettingPairArgument cfg.settings));

#  commandLineArguments = ''
#    ${evalArgument}${modulesArgument}${modulesRightArgument}${newlineArgument}${pathAliasesArgument}${otherSettingsArgument}
#  '';

in {
  meta.maintainers = [ maintainers.kr-nn ];
  options = {
    programs.powerlevel10k = {
      enable = mkEnableOption
        "Powerlevel10k is a theme for Zsh. It emphasizes speed, flexibility and out-of-the-box experience.";

      silenceModeMessage = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Running on first go should cause evaluation time to fail, allowing the user to know to run the p10k configure to determine the mode they need.
          alternatively if the mode is set to anything besides ascii, this is ignored. '';
        example = true;
      };

      mode = mkOption {
        default = "ascii";
        type = types.str;
        description = ''
           The mode determines multiple ways the font/icon rendering will work and changes if certain features will work.
           It is recommended to run the p10k configure script to know what works best for your terminal.
             - awesome-fontconfig
             - awesome-mapped-fontconfig
             - awesome-patched
             - nerdfont-complete
             - nerdfont-v3
             - flat
             - powerline
             - compatible
             - ascii
        '';
        example = "awesome-patched";
      };

       widgets = mkOption {
         type = types.submodule {
           options = {
             enable = mkEnableOption "widgets";

         #############################[ Current Time ] #################################

             currentTime = mkOption {
               type = types.submodule {
                 options = {
                   enable = mkEnableOption "clock";

                   format = mkOption {
                     type = types.str;
                     default = "%D{%H:%M:%S}";
                     description = ''
                       Format for the current time: 09:51:02. See `man 3 strftime`.
                       You can preview what you make here: https://strftime.net
                     '';
                     example = ''
                       Day of the year: "%j"
                       Standard ISO 8601: "%F" / "%Y-%m-%d"
                       Unix Time Epoch: "%s"
                     '';
                   };

                   updateOnCmd = mkOption {
                     type = types.bool;
                     default = false;
                     description = ''
                       If set to true, time will update when you hit enter. This way prompts for the past
                       commands will contain the start times of their commands as opposed to the default
                       behavior where they contain the end times of their preceding commands.
                     '';
                     example = true;
                   };

                   foregroundColor = mkOption {
                     type = types.int;
                     default = 16;
                     description = ''
                       Colors the text
                       ${colorsWarning}
                     '';
                     example = 5;
                   };

                   backgroundColor = mkOption {
                     type = types.int;
                     default = 7;
                     description = ''
                       Colors the background
                       ${colorsWarning}
                     '';
                     example = 5;
                   };

                   icon = mkOption {
                     type = types.nullOr (types.str);
                     default = null;
                     description = ''
                       Put an icon here to replace the default clock widget icon
                       ${unicodeSupportWarning}
                     '';
                     example = "⭐ or *";
                   };

                   prefix = mkOption {
                     type = types.str;
                     default = "at";
                     description = ''
                       The word(s) to put before the clock widget
                     '';
                     example = "the time is: ";
                   };

                 };
               };

               description = ''
                 This configures the clock module 'time'
               '';
               example = {
                 format = "%D{%H:%M:%S}";
                 updateOnCmd = true;
                 flowprefix = "the time is: ";
               };
             };

             #############################[ Current Dir ] #################################

             currentDir = mkOption {
               type = types.submodule {
                 options = {
                   enable = mkEnableOption "current directory";

                   foregroundColor = mkOption {
                     type = types.int;
                     default = 16;
                     description = ''
                       Colors the text
                       ${colorsWarning}
                     '';
                     example = 5;
                   };

                   backgroundColor = mkOption {
                     type = types.int;
                     default = 7;
                     description = ''
                       Colors the text
                       ${colorsWarning}
                     '';
                     example = 5;
                   };

                   icon = mkOption {
                     type = types.nullOr (types.str);
                     default = null;
                     description = ''
                       Put an icon here to replace the default dir widget icon
                       ${unicodeSupportWarning}
                     '';
                     example = "⭐ or *";
                   };

                   flowPrefix = mkOption {
                     type = types.str;
                     default = "in";
                     description = ''
                       The word(s) to put before the dir widget
                     '';
                     example = "We are in:";
                   };

                 };
               };

               description = ''
                 This configures the current directory widget.
               '';
               example = {};
             };
           };
        };

        description = ''
          The widgets to enable on the prompt.
        '';
        example = {
          currentTime = {
            enable = true;
            updateOnCmd = true;
            format = "%D{%H:%M:%S}";
            flowprefix = "the time is: ";
          };
        };
      };

      promptModules = mkOption {
        default = [ "dir" "vcs" ];
        type = types.nullOr (types.listOf (types.str));
        description = ''
          The modules to enable on the main prompt
          These go above the newline when newline is enabled, the order matters.
        '';
        example = [ "nix-shell" "direnv" "status" "context" ];
      };

      promptRightModules = mkOption {
        default = [
          "status" "command_execution_time" "background_jobs" "direnv" "asdf" "virtualenv" "anaconda" "pyenv" "goenv" "nodenv" "nvm"
          "nodeenv" "rbenv" "rvm" "fvm" "luaenv" "jenv" "plenv" "perlbrew" "phpenv" "scalaenv" "haskell_stack" "kubecontext" "terraform"
          "aws" "aws_eb_env" "azure" "gcloud" "google_app_cred" "toolbox" "context" "nordvpn" "ranger" "yazi" "nnn" "lf" "xplr"
          "vim_shell" "midnight_commander" "nix_shell" "chezmoi_shell" "todo" "timewarrior" "taskwarrior" "per_directory_history" "time"
        ];
        type = types.nullOr (types.listOf (types.str));
        description = ''
          The modules to enable on the right prompt
          These go above the newline when newline is enabled, the order matters.
        '';
        example = [ "nix-shell" "direnv" "status" "context" ];
      };

      newlineModules = mkOption {
        default = [ "prompt_char" ];
        type = types.nullOr (types.listOf (types.str));
        description = ''
          The modules to enable on the newline prompt
          These go on the newline when newline is enabled, the order matters.
          This has no effect if the newline is not enabled
          This has "prompt_char" by default, if you change it, include it
        '';
        example = [ "nix-shell" "direnv" "status" "context" ];
      };

      newlineRightModules = mkOption {
        default = null;
        type = types.nullOr (types.listOf (types.str));
        description = ''
          The modules to enable on the newline right prompt
          These go on the newline when newline is enabled, the order matters.
          This has no effect if the newline is not enabled
        '';
        example = [ "nix-shell" "direnv" "status" "context" ];
      };

      newline = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Set to true if the prompt should be on a line of its own.
        '';
        example = true;
      };

      transientPrompt = mkOption {
        default = "off";
        type = types.nullOr (types.str);
        description = ''
           Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
           when accepting a command line. Supported values:

             - off:      Don't change prompt when accepting a command line.
             - always:   Trim down prompt when accepting a command line.
             - same-dir: Trim down prompt when accepting a command line unless this is the first command
                         typed after changing current working directory.
        '';
        example = true;
      };

      instantPrompt = mkOption {
        default = "off";
        type = types.nullOr (types.str);
        description = ''
           Instant prompt mode
             - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
                        it incompatible with your zsh configuration files.
             - quiet:   Enable instant prompt and don't print warnings when detecting console output
                        during zsh initialization. Choose this if you've read and understood
                        https://github.com/romkatv/powerlevel10k#instant-prompt.
             - verbose: Enable instant prompt and print a warning when detecting console output during
                        zsh initialization. Choose this if you've never tried instant prompt, haven't
                        seen the warning, or if you are unsure what this all means.
        '';
        example = "verbose";
      };

      iconsBefore = mkOption {
        default = null;
        type = types.nullOr (types.bool);
        description = ''
          When set to true, icons appear before content on both sides of the prompt. When set
          to false, icons go after content. If empty or not set, icons go before content in the left
          prompt and after content in the right prompt.

          You can also override it for a specific segment:
            programs.powerlevel10k.extra = "POWERLEVEL9K_STATUS_ICON_BEFORE_CONTENT=false"

          Or for a specific segment in specific state:
            programs.powerlevel10k.extra = "POWERLEVEL9K_DIR_NOT_WRITABLE_ICON_BEFORE_CONTENT=false"
        '';
        example = true;
      };

      manyIcons = mkOption { default = false;
        type = types.bool;
        description = ''
          When set to true more icons will appear in your prompt
        '';
        example = true;
      };

      iconPadding = mkOption { default = false;
        type = types.bool;
        description = ''
          When set to true, more space is left between icons to accomodate overlap.
          Enable when you see icons overlapping.
        '';
        example = true;
      };

      disableHotReload = mkOption { default = true;
        type = types.bool;
        description = ''
          Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
          For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
          can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
          really need it.
        '';
        example = false;
      };

      noBoilerPlate = mkOption { default = false;
        type = types.bool;
        description = ''
          If you want to do more advanced things that require removing all the boilerplate from the top and bottom of the configuration file.
        '';
        example = true;
      };

      flow = mkOption {
        default = "concise";
        type = types.nullOr (types.str);
        description = ''
           Prompt flow
             - concise: Disable prompt prefixes.
             - fluent:  Enable prompt prefixes for easier reading
        '';
        example = "fluent";
      };

      compactSpacing = mkOption {
        default = false;
        type = types.bool;
        description = ''
           Whether or not to insert a newline before the new prompt displays
             - false:   Normal behavior
             - true:    Leave newlines between output and prompt
        '';
        example = "sparse";
      };

      extraTop = mkOption {
        default = "";
        description = "Extra text to place at the top of the configuration file (under the boilerplate)";
        example = ''
          # My Custom Prompt Widgets
          function prompt_example() {
            p10k segment -f 208 -i '*' -t 'hello, %n'
          }
          function instant_prompt_example() {
            prompt_example
          }
          typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=208
          typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'
        '';
        type = types.str;
      };

      extraBottom = mkOption {
        default = "";
        description = "Extra text to place at the bottom of the configuration file";
        example = ''
          # My Custom Prompt Widgets
          function prompt_example() {
            p10k segment -f 208 -i '*' -t 'hello, %n'
          }
          function instant_prompt_example() {
            prompt_example
          }
          typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=208
          typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'
        '';
        type = types.str;
      };
    };
  };

  config = {

    assertions = [
      { assertion = ( cfg.silenceModeMessage || cfg.mode != "ascii");
        message = ''It is recommended to run p10k configure to see what mode you should set under programs.powerlevel10k.mode.
                    To silence this message set programs.powerlevel10k.silenceModeMessage or set a mode other than "ascii" if you already know which one'';}

      { assertion = ( cfg.mode != "awesome-fontconfig" ||
                      cfg.mode != "awesome-mapped-fontconfig" ||
                      cfg.mode != "awesome-patched" ||
                      cfg.mode != "nerdfont-complete" ||
                      cfg.mode != "nerdfont-v3" ||
                      cfg.mode != "flat" ||
                      cfg.mode != "powerline" ||
                      cfg.mode != "compatible" ||
                      cfg.mode != "ascii" );
        message = "Module: programs.powerlevel10k.mode has an invalid option"; }

      { assertion = ( cfg.flow != "concise" || cfg.flow != "fluent" );
        message = "programs.powerlevel10k.flow has an invalid option"; }

      { assertion = ( cfg.transientPrompt != "off" || cfg.transientPrompt != "always" || cfg.transientPrompt != "same-dir" );
        message = "programs.powerlevel10k.flow has an invalid option"; }

      { assertion = ( cfg.instantPrompt != "off" || cfg.instantPrompt != "quiet" || cfg.instantPrompt != "verbose" );
        message = "programs.powerlevel10k.flow has an invalid option"; }

      { assertion = !( cfg.mode == "ascii" && cfg.manyIcons );
        message = "Cannot enable manyIcons when the mode is 'ascii'"; }
    ];

    programs.zsh.plugins = [ { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";} ];

    programs.zsh.initExtra = mkIf (cfg.enable && config.programs.zsh.enable) ''
      ### powerlevel10k =======================================
      source ${config.home.homeDirectory}/${config.programs.zsh.dotDir}/.p10k.zsh
    '';

    home.file."${config.home.homeDirectory}/${config.programs.zsh.dotDir}/.p10k.zsh".text = mkIf (cfg.enable && config.programs.zsh.enable) ''

      ${ if (cfg.noBoilerPlate) then ''
      ####################################[ Boiler plate: All configs need this ]####################################
      'builtin' 'local' '-a' 'p10k_config_opts'
      [[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
      [[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
      [[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
      'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'
      () {
        emulate -L zsh -o extended_glob
        unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
        [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || echo "\nYour zsh version is too old, please update to 5.1 or later\n" && return
      '' else ""}

      ####################################[ extra ]####################################
      ${cfg.extraTop}

      ####################################[ MODE ]####################################
        typeset -g POWERLEVEL9K_MODE=${cfg.mode}

      ####################################[ Modules: module placement ]####################################
        typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
          ${toString cfg.promptModules}
          ${if (cfg.newline) then "newline" else ""}
          ${toString cfg.newlineModules}
        )

        typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
          ${toString cfg.promptRightModules}
          ${if (cfg.newline) then "newline" else ""}
          ${toString cfg.newlineRightModules}
        )

      ####################################[ time: current time ]####################################
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_FORMAT=${cfg.widgets.currentTime.format}
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND="${toString cfg.widgets.currentTime.updateOnCmd}"
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION="${cfg.widgets.currentTime.icon}"
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_FOREGROUND=${toString cfg.widgets.currentTime.foregroundColor}
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_BACKGROUND=${toString cfg.widgets.currentTime.backgroundColor}
        ${if (cfg.widgets.currentTime.enable && cfg.flow == "fluent" ) then "" else "#"}typeset -g POWERLEVEL9K_TIME_PREFIX='%f${cfg.widgets.currentTime.prefix} '

      ####################################[ current directory ]####################################
        ${if (cfg.widgets.currentDir.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION="${cfg.widgets.currentDir.icon}"
        ${if (cfg.widgets.currentDir.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_FOREGROUND=${toString cfg.widgets.currentDir.foregroundColor}
        ${if (cfg.widgets.currentDir.enable) then "" else "#"}typeset -g POWERLEVEL9K_TIME_BACKGROUND=${toString cfg.widgets.currentDir.backgroundColor}
        ${if (cfg.widgets.currentDir.enable && cfg.flow == "fluent" ) then "" else "#"}typeset -g POWERLEVEL9K_TIME_PREFIX='%f${cfg.widgets.currentDir.prefix} '

      ####################################[ wifi: wifi speed ]####################################
        ${if (cfg.widgets.wifi.enable) then "" else "#"}typeset -g POWERLEVEL9K_WIFI_UPDATE_ON_COMMAND="${toString cfg.widgets.currentTime.updateOnCmd}"
        ${if (cfg.widgets.wifi.enable) then "" else "#"}typeset -g POWERLEVEL9K_WIFI_VISUAL_IDENTIFIER_EXPANSION="${cfg.widgets.currentTime.icon}"
        ${if (cfg.widgets.wifi.enable) then "" else "#"}typeset -g POWERLEVEL9K_WIFI_FOREGROUND=${toString cfg.widgets.wifi.foregroundColor}
        ${if (cfg.widgets.wifi.enable) then "" else "#"}typeset -g POWERLEVEL9K_WIFI_FORMAT=${cfg.widgets.currentTime.format}
        ${if (cfg.widgets.wifi.enable) then "" else "#"}typeset -g POWERLEVEL9K_WIFI_PREFIX='%f${cfg.widgets.currentTime.flowPrefix} '

      ####################################[ Misc Options ]####################################
        typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=${toString cfg.disableHotReload}
        typeset -g POWERLEVEL9K_ICON_PADDING=${if (cfg.iconPadding) then "moderate" else "none"}
        typeset -g POWERLEVEL9K_INSTANT_PROMPT=${cfg.instantPrompt}
        typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=${cfg.transientPrompt}
        typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=${toString cfg.compactSpacing}
        typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=${cfg.iconsBefore}

      ####################################[ Prefixes for flow ]####################################
        # TODO: set custom prefixes when enabled
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_DIR_PREFIX='%fin '
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_VCS_PREFIX='%fon '
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%ftook '
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_CONTEXT_PREFIX='%fwith '
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='%fat '
        ${if (cfg.widgets.currentTime.enable) then "" else "#"}typeset -g POWERLEVEL9K_TOOLBOX_PREFIX='%fin '

      ####################################[ extra ]####################################
      ${cfg.extraBottom}


      ####################################[ bottom boilerplate ]####################################
      ${ if (cfg.noBoilerPlate) then ''
        (( ! $+functions[p10k] )) || p10k reload
      }

      # Tell `p10k configure` which file it should overwrite.
      typeset -g POWERLEVEL9K_CONFIG_FILE=''${''${(%):-%x}:a}

      (( ''${#p10k_config_opts} )) && setopt ''${p10k_config_opts[@]}
      'builtin' 'unset' 'p10k_config_opts'

      '' else ""}
    '';
  };
}
