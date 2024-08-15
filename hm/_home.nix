{ config, pkgs, lib, ... }:
let

  themes = import ../theme/_theme.nix { inherit config pkgs lib; };

  # Collections ======================================================
  # Shortcuts to multiple configurations
  plasma = lib.mkMerge [ plasmaDotfiles plasmaPackages ];
  x11 = lib.mkMerge [ packagesGui ];
  work = lib.mkMerge [ gitWork ];

  # Touchegg =========================================================
  # For laptops that can use the trackpad and gestures (X11 only)
  touchpadInput = {
    home.file = {
      "${config.home.homeDirectory}/.config/touchegg/touchegg.conf".source = ./dotfiles/touchegg.conf;
      "${config.home.homeDirectory}/.config/touchpadxlibinputrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/touchpadxlibinputrc";
    };
  };

  # Git ==============================================================
  gitWork = {
    programs.git = { 
      userName = "krobinson";
      userEmail = "kyle.robinson@nocturnalnerd.xyz"; }; };

  # PKGS =============================================================
  packagesGui = { home.packages = with pkgs; [
    # docs
    obsidian onlyoffice-bin
    # vivaldi
    vivaldi vivaldi-ffmpeg-codecs widevine-cdm
    # System Packages
    kdePackages.partitionmanager
    # Social
    vesktop telegram-desktop signal-desktop
    # admin things
    bitwarden-desktop rustdesk yakuake
    # Fonts
    fira-code-nerdfont
    # entertainment
    mpv
  ]; };

  # Plasma ===========================================================

  framework-splash = {
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

  plasmaDotfiles = {
    home.file = {
      "${config.home.homeDirectory}/.config/yakuakerc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/yakuakerc";
      #"${config.home.homeDirectory}/.config/systemsettingsrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/systemsettingsrc";
      #"${config.home.homeDirectory}/.config/kiorc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/kiorc";
      #"${config.home.homeDirectory}/.config/kglobalshortcutsrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/kglobalshortcutsrc";
      #"${config.home.homeDirectory}/.config/mimeapps.list".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/mimeapps.list";
      "${config.home.homeDirectory}/.config/khotkeysrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/khotkeysrc";
    };
  };

  plasmaPackages = {
    home.packages = with pkgs; [
      libsForQt5.kwallet-pam
    ];
  };
in

# ====================================================================
# ====================================================================
# ====================================================================

{
  imports = [ ./_mods/zsh.nix ];

    # LEGOS =======================================================================
    # options you can add to profiles Defaults go in the default list
    # plasmaPackages plasmaDotfiles framework-splash packagesGui gitWork touchpadInput

    # Profiles =======================================================
    #specialisation.Default.configuration = lib.mkMerge [  ]; # This is already the parent configuration
    specialisation.Default-plasmax-shego.configuration                = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.spicyShego plasma x11 ];
    specialisation.Default-plasmax-vanessa.configuration              = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.suicideGirl plasma x11 ];
    specialisation.Default-plasmax-classytiddy.configuration          = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.classyTiddie plasma x11 ];
    specialisation.Default-plasmax-animefeet.configuration            = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.animeFeet plasma x11 ];
    specialisation.Default-plasmax-pinkpasties.configuration          = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.pinkPasties plasma x11 ];
    specialisation.Default-plasmax.configuration                      = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.emberRose plasma x11 ];
    specialisation.Default-plasmax-laptop.configuration               = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.emberRose plasma x11 touchpadInput framework-splash ];
    specialisation.Default-plasmax-laptop-shego.configuration         = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.spicyShego plasma x11 touchpadInput framework-splash ];
    specialisation.Default-plasmax-laptop-vanessa.configuration       = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.suicideGirl plasma x11 touchpadInput framework-splash ];
    specialisation.Default-plasmax-laptop-classytiddy.configuration   = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.classyTiddie plasma x11 touchpadInput framework-splash ];
    specialisation.Default-plasmax-laptop-animefeet.configuration     = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.animeFeet plasma x11 touchpadInput framework-splash ];
    specialisation.Default-plasmax-laptop-pinkpasties.configuration   = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.pinkPasties plasma x11 touchpadInput framework-splash ];

    specialisation.Work.configuration                                 = lib.mkMerge [ work ];
    specialisation.Work-plasmax-shego.configuration                   = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.spicyShego plasma x11 ];
    specialisation.Work-plasmax-vanessa.configuration                 = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.suicideGirl plasma x11 ];
    specialisation.Work-plasmax-classytiddy.configuration             = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.classyTiddie plasma x11 ];
    specialisation.Work-plasmax-animefeet.configuration               = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.animeFeet plasma x11 ];
    specialisation.Work-plasmax-pinkpasties.configuration             = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.pinkPasties plasma x11 ];
    specialisation.Work-plasmax.configuration                         = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.emberRose plasma x11 ];
    specialisation.Work-plasmax-laptop.configuration                  = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.emberRose plasma x11 touchpadInput framework-splash ];
    specialisation.Work-plasmax-laptop-shego.configuration            = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.spicyShego plasma x11 touchpadInput framework-splash ];
    specialisation.Work-plasmax-laptop-vanessa.configuration          = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.suicideGirl plasma x11 touchpadInput framework-splash ];
    specialisation.Work-plasmax-laptop-classytiddy.configuration      = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.classyTiddie plasma x11 touchpadInput framework-splash ];
    specialisation.Work-plasmax-laptop-animefeet.configuration        = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.animeFeet plasma x11 touchpadInput framework-splash ];
    specialisation.Work-plasmax-laptop-pinkpasties.configuration      = lib.mkMerge [ { stylix.enable = true; } themes.FiraMono themes.Dark themes.pinkPasties plasma x11 touchpadInput framework-splash ];

    specialisation.test.configuration                                 = lib.mkMerge [ x11 ];

    stylix.image = lib.mkDefault themes.nixos.stylix.image; # Silences error in stylix
  # SECRETS ==========================================================
    age.identityPaths = [
      "${config.home.homeDirectory}/.run/age.key"     # temporary storage for deployments
      "${config.home.homeDirectory}/.ssh/id_ed25519"  # main ssh key
      "${config.home.homeDirectory}/.ssh/age.key" ];  # Backup master key

  # Git ==============================================================
    age.secrets.git.file = ../secrets/kyle/git.age;
    age.secrets.git.path = "${config.home.homeDirectory}/.git-credentials";
    programs.git = {
      enable = true;
      userName = lib.mkDefault "kyle";
      userEmail = lib.mkDefault "kyle@nocturnalnerd.xyz";
      extraConfig = {
        credential.helper = "store"; # Use git-credentials
        safe.directory = "/etc/nixos"; }; };

  # Packages =========================================================
    home.packages = with pkgs; [

      # Shell tools
      tmux bat fzf fd parallel ctpv eza ripgrep age git curl nmap fastfetch usbutils pciutils htop

      # Terminal Apps
      bitwarden-cli glow




      # Neovim
      zip unzip gcc cargo neovim

      # Nix things
      nix-prefetch-git
      (pkgs.writeShellScriptBin "flink"
       (builtins.readFile ./scripts/flink) )
      (pkgs.writeShellScriptBin "hmpr"
       (builtins.readFile ./scripts/hmpr) )
      (pkgs.writeShellScriptBin "nr" ''
        nix run nixpkgs#"$1" -- ''${@:2}'')
      (pkgs.writeShellScriptBin "ns" ''
        nix shell nixpkgs#"$1" -- ''${@:2}'')
      (pkgs.writeShellScriptBin "nri" ''
        nix run nixpkgs#"$1" --impure -- ''${@:2}'')
      (pkgs.writeShellScriptBin "nsi" ''
        nix shell nixpkgs#"$1" --impure -- ''${@:2}'')

    ];

  # DOTFILES =========================================================
    home.file = {
      # Neovim
      "${config.home.homeDirectory}/.config/nvim/init.lua".source = ../hm/dotfiles/nvim/init.lua;
      "${config.home.homeDirectory}/.config/nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/nvim/lazy-lock.json";
    };

  # ENV ==============================================================
    home.sessionVariables = {
      EDITOR = "nvim";
      NIXPKGS_ALLOW_UNFREE = "1"; # for nri/nsi impure running/shells
    };

    # META ===========================================================
    # TODO: Change this to entryAfter as early as possible in the activation, make less work necessary;
    home.activation.profileSwitcher = lib.hm.dag.entryAfter ["linkGeneration"] ''
      PATH="${config.home.path}/bin:$PATH:${pkgs.gawk}/bin"
      export HMGENERATIONPATH="$HOME/.config/home-manager/.hmgeneration"
      export HMPROFILEPATH="$HOME/.config/home-manager/.hmprofile"
      export HMGENERATION="$(home-manager generations | head -n 1 | gawk '{ print($7) }')"
      echo "HMGENERATION: $HMGENERATION"

      if [ -d "$HMGENERATION/specialisation" ]; then
        echo "Updating to newest generation: $HMGENERATION"
        echo $HMGENERATION > $HMGENERATIONPATH

        if [ -e $HMPROFILEPATH ]; then
          export HMPROFILE=$(head -n 1 $HMPROFILEPATH)
          if [ $HMPROFILE = "default" ]; then
            :
          elif [ -z $HMPROFILE ]; then
            hmpr bootstrap
          elif [ -n $HMPROFILE ]; then
            hmpr $HMPROFILE
          fi
        else
          echo "HMPROFILE does not exist, bootstrapping..."
          hmpr bootstrap
        fi
      else
        :
      fi
    '';

    home.activation.konsolerc = lib.hm.dag.entryAfter ["profileSwitcher"] ''
      PATH="${config.home.path}/bin:$PATH:${pkgs.jq}"
      palette=$HOME/.config/stylix/palette.json
      scheme=$HOME/.local/share/konsole/Stylix.colorscheme

      if ! [ -f $palette ]; then
        echo "Palette doesn't exist"
      else
        json=$( cat $palette )

        hex_to_rgb() {
          hex=$1
          r=$((16#''${hex:0:2}))
          g=$((16#''${hex:2:2}))
          b=$((16#''${hex:4:2}))
          echo "$r,$g,$b"
        }

        for base in base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F; do
          hex=$(echo "$json" | jq -r ".$base")
          rgb=$(hex_to_rgb "$hex")
          declare "''${base}_rgb=$rgb"
        done

        mustache_template="
        [Background]
        Color={{base00-rgb-r}},{{base00-rgb-g}},{{base00-rgb-b}}
        [BackgroundIntense]
        Color={{base03-rgb-r}},{{base03-rgb-g}},{{base03-rgb-b}}
        [Color0]
        Color={{base00-rgb-r}},{{base00-rgb-g}},{{base00-rgb-b}}
        [Color0Intense]
        Color={{base03-rgb-r}},{{base03-rgb-g}},{{base03-rgb-b}}
        [Color1]
        Color={{base08-rgb-r}},{{base08-rgb-g}},{{base08-rgb-b}}
        [Color1Intense]
        Color={{base08-rgb-r}},{{base08-rgb-g}},{{base08-rgb-b}}
        [Color2]
        Color={{base0B-rgb-r}},{{base0B-rgb-g}},{{base0B-rgb-b}}
        [Color2Intense]
        Color={{base0B-rgb-r}},{{base0B-rgb-g}},{{base0B-rgb-b}}
        [Color3]
        Color={{base0A-rgb-r}},{{base0A-rgb-g}},{{base0A-rgb-b}}
        [Color3Intense]
        Color={{base0A-rgb-r}},{{base0A-rgb-g}},{{base0A-rgb-b}}
        [Color4]
        Color={{base0D-rgb-r}},{{base0D-rgb-g}},{{base0D-rgb-b}}
        [Color4Intense]
        Color={{base0D-rgb-r}},{{base0D-rgb-g}},{{base0D-rgb-b}}
        [Color5]
        Color={{base0E-rgb-r}},{{base0E-rgb-g}},{{base0E-rgb-b}}
        [Color5Intense]
        Color={{base0E-rgb-r}},{{base0E-rgb-g}},{{base0E-rgb-b}}
        [Color6]
        Color={{base0C-rgb-r}},{{base0C-rgb-g}},{{base0C-rgb-b}}
        [Color6Intense]
        Color={{base0C-rgb-r}},{{base0C-rgb-g}},{{base0C-rgb-b}}
        [Color7]
        Color={{base05-rgb-r}},{{base05-rgb-g}},{{base05-rgb-b}}
        [Color7Intense]
        Color={{base07-rgb-r}},{{base07-rgb-g}},{{base07-rgb-b}}
        [Foreground]
        Color={{base05-rgb-r}},{{base05-rgb-g}},{{base05-rgb-b}}
        [ForegroundIntense]
        Color={{base07-rgb-r}},{{base07-rgb-g}},{{base07-rgb-b}}
        [General]
        Description=Stylix
        Opacity=0.75
        Wallpaper=
        "
        populated_template=$(echo "$mustache_template" \
          | sed "s/{{base00-rgb-r}},{{base00-rgb-g}},{{base00-rgb-b}}/$base00_rgb/g" \
          | sed "s/{{base03-rgb-r}},{{base03-rgb-g}},{{base03-rgb-b}}/$base03_rgb/g" \
          | sed "s/{{base08-rgb-r}},{{base08-rgb-g}},{{base08-rgb-b}}/$base08_rgb/g" \
          | sed "s/{{base0B-rgb-r}},{{base0B-rgb-g}},{{base0B-rgb-b}}/$base0B_rgb/g" \
          | sed "s/{{base0A-rgb-r}},{{base0A-rgb-g}},{{base0A-rgb-b}}/$base0A_rgb/g" \
          | sed "s/{{base0D-rgb-r}},{{base0D-rgb-g}},{{base0D-rgb-b}}/$base0D_rgb/g" \
          | sed "s/{{base0E-rgb-r}},{{base0E-rgb-g}},{{base0E-rgb-b}}/$base0E_rgb/g" \
          | sed "s/{{base0C-rgb-r}},{{base0C-rgb-g}},{{base0C-rgb-b}}/$base0C_rgb/g" \
          | sed "s/{{base05-rgb-r}},{{base05-rgb-g}},{{base05-rgb-b}}/$base05_rgb/g" \
          | sed "s/{{base07-rgb-r}},{{base07-rgb-g}},{{base07-rgb-b}}/$base07_rgb/g")
        echo "$populated_template" > $scheme
      fi

    '';
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
}


