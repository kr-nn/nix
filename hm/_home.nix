{ config, pkgs, lib, ... }:
let

main = lib.mkMerge [ Default activeProfiles activations ];
### ==========================================================================
### ==========================================================================
### ==========================================================================
### =====                                                                =====
### =====  ██████╗ ██████╗  ██████╗ ███████╗██╗██╗     ███████╗███████╗  =====
### =====  ██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║██║     ██╔════╝██╔════╝  =====
### =====  ██████╔╝██████╔╝██║   ██║█████╗  ██║██║     █████╗  ███████╗  =====
### =====  ██╔═══╝ ██╔══██╗██║   ██║██╔══╝  ██║██║     ██╔══╝  ╚════██║  =====
### =====  ██║     ██║  ██║╚██████╔╝██║     ██║███████╗███████╗███████║  =====
### =====  ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  =====
### =====                                                                =====
### ==========================================================================
### ==========================================================================
### ==========================================================================
###_Profiles

# collections
plasma = lib.mkMerge [ dotfilesPlasma packagesPlasma ];
x11 = lib.mkMerge [ packagesGui dotfilesTouchegg];
work = lib.mkMerge [ gitWork ];

Default = lib.mkMerge [ zshDefault secretsDefault gitDefault packagesDefault envDefault meta dotfilesNeovim ];

activeProfiles = { # NOTE: Only activate some of these profiles when making tests and building home-manager, building all of them takes a long time
  #specialisation.Default.configuration                                 = lib.mkMerge [ Default ]; # This is already the parent generation
  specialisation.Default-plasmax.configuration                      = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeEmberRose plasma x11 ];
  specialisation.Default-plasmax-laptop.configuration               = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themePinkPasties plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Default-plasmax-shego.configuration                = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSpicyShego plasma x11 ];
  #specialisation.Default-plasmax-vanessa.configuration              = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSuicideGirl plasma x11 ];
  #specialisation.Default-plasmax-classytiddy.configuration          = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeClassyTiddie plasma x11 ];
  #specialisation.Default-plasmax-animefeet.configuration            = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeAnimeFeet plasma x11 ];
  #specialisation.Default-plasmax-pinkpasties.configuration          = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themePinkPasties plasma x11 ];
  #specialisation.Default-plasmax-laptop-shego.configuration         = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSpicyShego plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Default-plasmax-laptop-vanessa.configuration       = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSuicideGirl plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Default-plasmax-laptop-classytiddy.configuration   = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeClassyTiddie plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Default-plasmax-laptop-animefeet.configuration     = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeAnimeFeet plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Default-plasmax-laptop-pinkpasties.configuration   = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themePinkPasties plasma x11 dotfilesTouchegg ksplashFramework ];

  specialisation.Work.configuration                                 = lib.mkMerge [ work ];
  specialisation.Work-plasmax.configuration                         = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeParrotSec plasma x11 work ];
  specialisation.Work-plasmax-laptop.configuration                  = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeParrotSec plasma x11 dotfilesTouchegg ksplashFramework work ];
  #specialisation.Work-plasmax-shego.configuration                   = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSpicyShego plasma x11 ];
  #specialisation.Work-plasmax-vanessa.configuration                 = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSuicideGirl plasma x11 ];
  #specialisation.Work-plasmax-classytiddy.configuration             = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeClassyTiddie plasma x11 ];
  #specialisation.Work-plasmax-animefeet.configuration               = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeAnimeFeet plasma x11 ];
  #specialisation.Work-plasmax-pinkpasties.configuration             = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themePinkPasties plasma x11 ];
  #specialisation.Work-plasmax-laptop.configuration                  = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeEmberRose plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Work-plasmax-laptop-shego.configuration            = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSpicyShego plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Work-plasmax-laptop-vanessa.configuration          = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeSuicideGirl plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Work-plasmax-laptop-classytiddy.configuration      = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeClassyTiddie plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Work-plasmax-laptop-animefeet.configuration        = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themeAnimeFeet plasma x11 dotfilesTouchegg ksplashFramework ];
  #specialisation.Work-plasmax-laptop-pinkpasties.configuration      = lib.mkMerge [ { stylix.enable = true; } yakuakeskinDark fontFiraMono polarityDark themePinkPasties plasma x11 dotfilesTouchegg ksplashFramework ];

  #specialisation.test.configuration                                 = lib.mkMerge [ x11 ];
};

### =============================================================
### =============================================================
### =============================================================
### =====                                                   =====
### =====   ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗   =====
### =====  ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝   =====
### =====  ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗  =====
### =====  ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║  =====
### =====  ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝  =====
### =====   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝   =====
### =====                                                   =====
### =============================================================
### =============================================================
### =============================================================
###_Config

# SECRETS ==========================================================
secretsDefault = {
  age.identityPaths = [
    "${config.home.homeDirectory}/.run/age.key"      # temporary storage for deployments
    "${config.home.homeDirectory}/.ssh/id_ed25519"   # main ssh key
    "${config.home.homeDirectory}/.ssh/age.key" ];}; # backup master key

# Git ==============================================================

gitWork = {
  programs.git = {
    userName = "krobinson";
    userEmail = "kyle.robinson@nocturnalnerd.xyz"; }; };

gitDefault = {
  age.secrets.git.file = ../secrets/git.age;
  age.secrets.git.path = "${config.home.homeDirectory}/.git-credentials";
  programs.git = {
    enable = true;
    userName = lib.mkDefault "kyle";
    userEmail = lib.mkDefault "kyle@nocturnalnerd.xyz";
    extraConfig = {
      credential.helper = "store"; # Use git-credentials
      safe.directory = "/etc/nixos"; };};};

# Packages =========================================================
packagesPlasma = {
  home.packages = with pkgs; [
    libsForQt5.kwallet-pam ];};

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
  # Entertainment
  mpv feishin ];};

packagesDefault = { home.packages = with pkgs; [
  # Shell tools
  tmux bat fzf fd parallel ctpv eza ripgrep age git curl nmap fastfetch usbutils pciutils htop jq
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
    nix shell nixpkgs#"$1" --impure -- ''${@:2}'') ];};

envDefault = {
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = "1";  }; }; # for nri/nsi impure running/shells

meta = { # Things home-manager needs to do the things I need
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
};

### ===========================================================================
### ===========================================================================
### ===========================================================================
### =====                                                                 =====
### =====  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗  =====
### =====  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝  =====
### =====  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗  =====
### =====  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║  =====
### =====  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║  =====
### =====  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  =====
### =====                                                                 =====
### ===========================================================================
### ===========================================================================
### ===========================================================================
###_Dotfiles

dotfilesPlasma = {
  home.file = {
    "${config.home.homeDirectory}/.config/yakuakerc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/yakuakerc";
    "${config.home.homeDirectory}/.config/touchpadxlibinputrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/touchpadxlibinputrc";
    "${config.home.homeDirectory}/.config/systemsettingsrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/systemsettingsrc";
    "${config.home.homeDirectory}/.config/kglobalshortcutsrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/kglobalshortcutsrc";
    "${config.home.homeDirectory}/.config/mimeapps.list".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/mimeapps.list";
    "${config.home.homeDirectory}/.config/khotkeysrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/khotkeysrc"; }; };

dotfilesNeovim = {
  home.file = {
    "${config.home.homeDirectory}/.config/nvim/init.lua".source = ../hm/dotfiles/nvim/init.lua;
    "${config.home.homeDirectory}/.config/nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/nvim/lazy-lock.json"; }; };

dotfilesTouchegg = {
  home.file = {
    "${config.home.homeDirectory}/.config/touchegg/touchegg.conf".source = ./dotfiles/touchegg.conf;
    "${config.home.homeDirectory}/.config/touchpadxlibinputrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/touchpadxlibinputrc"; }; };

### ======================================================
### ======================================================
### ======================================================
### =====                                            =====
### =====  ███████╗██╗  ██╗███████╗██╗     ██╗       =====
### =====  ██╔════╝██║  ██║██╔════╝██║     ██║       =====
### =====  ███████╗███████║█████╗  ██║     ██║       =====
### =====  ╚════██║██╔══██║██╔══╝  ██║     ██║       =====
### =====  ███████║██║  ██║███████╗███████╗███████╗  =====
### =====  ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝  =====
### =====                                            =====
### ======================================================
### ======================================================
### ======================================================
###_Shell
 
### FZF configuration:
# ! NOTE Performance disclaimer

# low perf search uses plocate, so your searches will be fast, but possibly out of date depending on when the database was last indexed.
#     you can manually update the index with updatedb For reasons that the high perf mode is dangerous, this is the default

# high perf mode: ! WARNING This is a dangerous command for your CPU. You can quickly and easily pin your CPU.
#     This is a fast and live search, but if you have a large folder it will continue to run after you exit fzf.
#     Should you still want to use it:
#     You should benchmark your optimal command based on how deep you want to search, change the --max-depth 6 below.
#     time fd --type d . / --max-depth 1 | parallel time fd . {} --max-depth 6 |grep ^fd
#     There is an easy alias for this for you (without the --max-depth ):
#     fdbench = "time fd --type d . / --max-depth 1 | parallel time fd . {} |grep ^fd";

# low perf search # not always up to date
lrootsearch="locate /";
lpwdsearch="locate $PWD";
lhomesearch="locate $HOME";

# High perf search # always up to date
# Search files and directories
rootsearch=  "{fd /     --type f . --max-depth 1 --hidden; fd --type d . /     --max-depth 1 --hidden | parallel fd . {} --hidden}";
pwdsearch=   "{fd $PWD  --type f . --max-depth 1 --hidden; fd --type d . $PWD  --max-depth 1 --hidden | parallel fd . {} --hidden}";
homesearch=  "{fd $HOME --type f . --max-depth 1 --hidden; fd --type d . $HOME --max-depth 1 --hidden | parallel fd . {} --hidden}";

# Searches Files
frootsearch=  "{fd /     --type f . --max-depth 1 --hidden; fd --type d . /     --max-depth 1 --hidden | parallel fd . {} --type f --hidden}";
fpwdsearch=   "{fd $PWD  --type f . --max-depth 1 --hidden; fd --type d . $PWD  --max-depth 1 --hidden | parallel fd . {} --type f --hidden}";
fhomesearch=  "{fd $HOME --type f . --max-depth 1 --hidden; fd --type d . $HOME --max-depth 1 --hidden | parallel fd . {} --type f --hidden}";

# Searches Directories
drootsearch=  "{fd --type d . /     --max-depth 1 --hidden | parallel fd . {} --type d --hidden}";
dpwdsearch=   "{fd --type d . $PWD  --max-depth 1 --hidden | parallel fd . {} --type d --hidden}";
dhomesearch=  "{fd --type d . $HOME --max-depth 1 --hidden | parallel fd . {} --type d --hidden}";

### FZF config ^^^^^^^^ ==============================================================================

fzf-tab = pkgs.fetchgit {
    url = "https://github.com/Aloxaf/fzf-tab";
    rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
    sha256 = "0hv21mp6429ny60y7fyn4xbznk31ab4nkkdjf6kjbnf6bwphxxnk"; };

zsh-ssh = pkgs.fetchgit {
    url = "https://github.com/kr-nn/zsh-ssh";
    rev = "e14ecc35e916a644d2ba025c41791631463c2e8d";
    sha256 = "0xa2m59qaqh7niz290il1b1vnmwfbbprbkyfgxrswybw7nzg5m1n"; };

nix-shell = pkgs.fetchgit {
    url = "https://github.com/chisui/zsh-nix-shell";
    rev = "82ca15e638cc208e6d8368e34a1625ed75e08f90";
    sha256 = "1l99ayc9j9ns450blf4rs8511lygc2xvbhkg1xp791abcn8krn26"; };

omz_custom_plugins_path = "${config.home.homeDirectory}/.oh-my-zsh/custom/plugins/";
omz_custom_themes_path = "${config.home.homeDirectory}/.oh-my-zsh/custom/themes/";
zdir = "${config.xdg.dataHome}/zsh";

zshDefault = {
  programs.bash = { enable=true; initExtra = "zsh"; historyFile = "${zdir}/bash_history"; }; # change shell to zsh when in a bash shell
  programs.zsh = {
    history.path = "${zdir}/.zsh_history";
    dotDir = ".local/share/zsh";
    enable = true;
    shellAliases = {
      # neovim
      vim="nvim";
      vimrc="$EDITOR ~/.config/home-manager/hm/dotfiles/nvim/init.lua";

      # nixos configs
      no="nixos-rebuild";
      nocd="cd /etc/nixos";
      norc="$EDITOR /etc/nixos/hosts/$(cat /etc/hostname)/configuration.nix";
      nosw="sudo nixos-rebuild switch";
      note="sudo nixos-rebuild test";
      nobo="sudo nixos-rebuild boot";
      nobu="sudo nixos-rebuild build";

      # home-manager
      hm="home-manager";
      hmcd="cd ~/.config/home-manager/";
      hmrc="hmcd && $EDITOR ~/.config/home-manager/hm/_home.nix && cd -";
      hmsw="home-manager switch";
      hmbu="home-manager build";

      # convenience
      fdbench = "time fd --type d . / --max-depth 1 | parallel time fd . {}|grep ^fd"; # Benchmarks the high performance search of fzf
      src="source ${zdir}/.zshrc";
      sshrc="$EDITOR ~/.ssh/config";
      ll="eza -lhg --group-directories-first";
      l="eza -g --group-directories-first";
      lla="eza -lhag --group-directories-first";
      la="eza -ag --group-directories-first";
      ff="fastfetch";
      cat="bat -p";
      myip="curl api.ipify.org";
      cl="clear";
      cheat = "curl cheat.sh/$1";
    };

    oh-my-zsh = { enable = true; theme = "agnoster-nix"; plugins = [
        "vi-mode"
        "aliases"
        "git"
        "fzf"
        "sudo"
        "themes"
        "virtualenv"
        "fzf-tab"
        "zsh-ssh"
        "nix-shell"
      ];
    };

    initExtra =  ''
        ### fzf-tab =============================================
        zstyle ':completion:*:git-checkout:*' sort true
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:*' fzf-preview 'ctpv $realpath'
        zstyle ':fzf-tab:*' fzf-flags '--height=100%'

        ### zsh options =========================================
        # Configures !! to automatically execute
        unsetopt HIST_VERIFY

        ### FZF widgets =========================================

        ### ================================================================================================================================================
        ### open file with xdg-open ========================================================================================================================
        ### Ctrl + o =======================================================================================================================================
        ### ================================================================================================================================================

        fzf_open_file() {
          local cmd="''${FZF_CTRL_O_COMMAND:-''${DEFAULT_COMMAND:-"find . -type f"}}"
          local opts="''${FZF_CTRL_O_OPTS''${DEFAULT_OPTS:-""}}"
          if [ -n "$file" ];
            then echo opening...
              xdg-open "$file" > /dev/null 2>&1
              zle accept-line
          fi
        }
        zle -N fzf_open_file_widget fzf_open_file
        bindkey '^o' fzf_open_file_widget

        ### ================================================================================================================================================
        ### edit file with $EDITOR =========================================================================================================================
        ### Ctrl + e =======================================================================================================================================
        ### ================================================================================================================================================

        fzf_edit_file() {
          local cmd="''${FZF_CTRL_E_COMMAND:-''${DEFAULT_COMMAND:-"find . -type f"}}"
          local opts="''${FZF_CTRL_E_OPTS:-''${DEFAULT_OPTS:-""}}"
          setopt localoptions pipefail no_aliases 2> /dev/null
          local file
          file=$(eval "$cmd" | fzf $opts)
          if [ -n "$file" ]; then
            $EDITOR "$file" </dev/tty
          fi
        }
        zle -N fzf_edit_file_widget fzf_edit_file
        bindkey '^e' fzf_edit_file_widget 

        ### Vaultwarden init ===============================================================================================================================
        AGEPATH="/run/user/$UID/age.key"
        BWPATH="/run/user/$UID/bwsession"

        if [ -n $BW_SESSION ]; then
          echo $BW_SESSION > $BWPATH
        elif [ -f $BWPATH ]; then
          session=$(head -n 1 $BWPATH)
        else
          STATUS=$(bw status | jq .status)
          if [ "$STATUS" = "\"unauthenticated\"" ]; then
            bw config server https://vaultwarden.nocturnalnerd.xyz
            session=$(bw login --raw)
          elif [ "$STATUS" = "\"locked\"" ]; then
            session=$(bw unlock --raw)
          fi
          echo $session > $BWPATH
        fi
        export BW_SESSION="$session"

        if ! [ -f $AGEPATH ]; then
          echo $(bw get password af9d248c-93e9-4de4-8e15-61b5801d326c) > $AGEPATH
        fi

        if ! [ -L ~/.ssh/age.key ]; then
          ln -s $AGEPATH ~/.ssh/age.key
        fi
        '';
  };

  home.packages = with pkgs; [
    oh-my-zsh
    zsh
  ];

  home.file = {
    "${omz_custom_plugins_path}fzf-tab".source = fzf-tab;
    "${omz_custom_plugins_path}zsh-ssh".source = zsh-ssh;
    "${omz_custom_plugins_path}nix-shell".source = nix-shell;
    "${omz_custom_themes_path}agnoster-nix.zsh-theme".source = ./dotfiles/oh-my-zsh/agnoster-nix.zsh-theme;
  };

  home.sessionVariables = {
    # LANG="C.UTF-8"; I don't remember why I needed this. put back if I need it still
    ZSH_CUSTOM="${config.home.homeDirectory}/.oh-my-zsh/custom";
    FZF_DEFAULT_COMMAND=rootsearch;
    FZF_DEFAULT_OPTS=" --preview 'ctpv {}' --height=100% --reverse";

    HYPHEN_INSENSITIVE="true";
    COMPLETION_WAITING_DOTS="true";

    # CTRL + O Opens a file with xdg-open
    FZF_CTRL_O_COMMAND=fhomesearch;
    #export FZF_CTRL_O_OPTS=

    # CTRL + E Opens an editor with the selected file
    FZF_CTRL_E_COMMAND=fhomesearch;
    #export FZF_CTRL_O_OPTS=

    # Ctrl + T pastes the selected path to the CLI where your cursor is
    FZF_CTRL_T_COMMAND=homesearch;

    # ALT + C cd's to the selected entry
    # By Default it searches your current Directory and cd's to the directory you select
    FZF_ALT_C_COMMAND=dhomesearch;
    #export FZF_ALT_C_OPTS=""

    # CTRL + R Replaces your current entry with the selected result
    # By default it searches your history, it inlcudes your current entry with what you've typed already
    #export FZF_CTRL_R_COMMAND=""
    #export FZF_CTRL_R_OPTS=""
  };
};

### ==================================================================
### ==================================================================
### ==================================================================
### =====                                                        =====
### =====  ████████╗██╗  ██╗███████╗███╗   ███╗███████╗███████╗  =====
### =====  ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝██╔════╝  =====
### =====     ██║   ███████║█████╗  ██╔████╔██║█████╗  ███████╗  =====
### =====     ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  ╚════██║  =====
### =====     ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗███████║  =====
### =====     ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚══════╝  =====
### =====                                                        =====
### ==================================================================
### ==================================================================
### ==================================================================
###_Themes


# Plasma loading screen
ksplashFramework = {
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

# Polarity
polarityDark = { stylix.polarity = "dark"; };
#Light = { stylix.polarity = "light"; };

fontFiraMono = { stylix.fonts = { monospace.package = pkgs.fira-code-nerdfont; monospace.name = "nerdfonts-3.2.1"; }; };

# Wallpapers/colorschemes =============================================
## nixos
themeNixos = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
  sha256 = "07zl1dlxqh9dav9pibnhr2x1llywwnyphmzcdqaby7dz5js184ly"; }; };

## rose embers
themeEmberRose = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/lq/wallhaven-lqmzkq.jpg";
  sha256 = "1fsja8fk86b8n971gmfw963f338s6z7yf5706a3sfn94ly22hw0b"; }; };

## Parrotsyec green
themeParrotSec = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
  sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3"; }; };

# Spicy ===============

## Degen weeb shit, pink, black and white
themeAnimeFeet = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/1p/wallhaven-1peygv.jpg";
  sha256 = "0zn89k6ipzk27vf11f9hqkzx0nk3b0nabs796mip2jf7d7cjmp1q"; }; };

## A dark greyscale image with a beautiful women adorning voluptuous breasts
themeClassyTiddie = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/d6/wallhaven-d62llg.jpg";
  sha256 = "1yvp346s9bvqjwn9jviccml13qp3ny075w7xrnzba09xvlmpbv2m"; }; };

## Pink and Black pasties
themePinkPasties = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/g8/wallhaven-g891mq.jpg";
  sha256 = "0kdzdny260klqz6mprns3641a59f652w9ppyy89dair07wb9a634"; }; };

## tattood suicide girl in bathtub: Apr 24th 2024 vaneskka Gushwater
themeSuicideGirl = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/m3/wallhaven-m362lm.jpg";
  sha256 = "0p2rls33jii573mzzc7ywkw0v0i0phkxfdxb3bmdh7glqavci7ba"; }; };

## A Very spicy Shego cosplay with green black and grey colorscheme
themeSpicyShego = { stylix.image = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/l8/wallhaven-l8ogop.jpg";
  sha256 = "1w8w9l1fpd7y6svfvs6p49xy2kma0cdg9r8i4lfmh66535fvmy7d"; }; };

# App skins ==========================================================
## Yakuake Skin
yakuakeskinDark = { home.file."${config.home.homeDirectory}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
  url = "https://github.com/kr-nn/noskin-yakuake";
  rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
  sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
}; };

yakuakeskinLight = { home.file."${config.home.homeDirectory}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
  url = "https://github.com/kr-nn/noskin-yakuake";
  rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
  sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
}; };

yakuakeskinTransparent = { home.file."${config.home.homeDirectory}/.local/share/yakuake/kns_skins/noskin/".source = pkgs.fetchgit {
  url = "https://github.com/kr-nn/noskin-yakuake";
  rev = "7c247eac0f63d83c804ca0d8be84add2286c3b2e";
  sha256 = "12220i5cljrlbp0r9ybmi1zmyw20jky6azvrj6ivglnfpzsvckzh";
}; };

### ==================================================================================================
### ==================================================================================================
### ==================================================================================================
### =====                                                                                        =====
### =====   █████╗  ██████╗████████╗██╗██╗   ██╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗███████╗  =====
### =====  ██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║██╔════╝  =====
### =====  ███████║██║        ██║   ██║██║   ██║███████║   ██║   ██║██║   ██║██╔██╗ ██║███████╗  =====
### =====  ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══██║   ██║   ██║██║   ██║██║╚██╗██║╚════██║  =====
### =====  ██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║███████║  =====
### =====  ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝  =====
### =====                                                                                        =====
### ==================================================================================================
### ==================================================================================================
### ==================================================================================================
###_Activations

  activations = {
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
      Opacity=0.85
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
    fi ''; };

in
main
