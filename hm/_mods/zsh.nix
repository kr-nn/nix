{ config, pkgs, ... }:

let # ==================================================================================================================================================

### FZF configuration:

# ! NOTE Performance disclaimer
# low perf mode:
# low perf search uses plocate, so your searches will be fast, but possibly out of date depending on when the database was last indexed you can manually update the index with updatedb For reasons that the high perf mode is dangerous, this is the default
# high perf mode: ! WARNING This is a dangerous command for your CPU
# This is a fast and live search, but if you have a large folder it will continue to run after you finish with fzf
# You can quickly and easily pin your CPU.
# Should you still want to use it:
# You should benchmark your optimal command based on how deep you want to search, change the --max-depth 6 below.
# Ex. | time fd . / --max-depth 1; time fd --type d . / --max-depth 1 | parallel time fd . {} --max-depth 6 |grep fd |grep -v /usr
# I tend to have best results with --max-depth 6 from / and 5 from $HOME
# You may have different results or requirements
# You can include --exclude /path/name to not search certain folders

# low perf search # not always up to date
lrootsearch="locate /";
lpwdsearch="locate $PWD";
lhomesearch="locate $HOME";
# time fd --type d . / --max-depth 1 | parallel time fd . {}|grep ^fd
# High perf search # always up to date
# Search files and directories
rootsearch="{fd . / --max-depth 1 --hidden; fd --type d . / --max-depth 1 --hidden | parallel fd . {} --hidden}";
pwdsearch="{fd . $PWD --max-depth 1 --hidden; fd --type d . $PWD --max-depth 1 --hidden | parallel fd . {} --hidden}";
homesearch="{fd . $HOME --max-depth 1 --hidden; fd --type d . $HOME --max-depth 1 --hidden | parallel fd . {} --hidden}";

# Searches Files
frootsearch="{fd --type f . / --max-depth 1 --hidden; fd --type d . / --max-depth 1 --hidden | parallel fd . {} --hidden --type f}";
fpwdsearch="{fd --type f . $PWD --max-depth 1 --hidden; fd --type d . $PWD --max-depth 1 --hidden | parallel fd . {} --hidden --type f}";
fhomesearch="{fd --type f . $HOME --max-depth 1 --hidden; fd --type d . $HOME --max-depth 1 --hidden | parallel fd . {} --hidden --type f}";

# Searches Directories
drootsearch="{fd --type d . / --max-depth 1; --hidden fd --type d . / --max-depth 1 --hidden | parallel fd . {} --hidden --type d}";
dpwdsearch="{fd --type d . $PWD --max-depth 1 --hidden; fd --type d . $PWD --max-depth 1 --hidden | parallel fd . {} --hidden --type d}";
dhomesearch="{fd --type d . $HOME --max-depth 1 --hidden; fd --type d . $HOME --max-depth 1 --hidden | parallel fd . {} --hidden --type d}";

### FZF config ^^^^^^^^ ==============================================================================

  fzf-tab = pkgs.fetchgit {
      url = "https://github.com/Aloxaf/fzf-tab";
      rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
      sha256 = "0hv21mp6429ny60y7fyn4xbznk31ab4nkkdjf6kjbnf6bwphxxnk";
    };

  zsh-ssh = pkgs.fetchgit {
      url = "https://github.com/kr-nn/zsh-ssh";
      rev = "e14ecc35e916a644d2ba025c41791631463c2e8d";
      sha256 = "0xa2m59qaqh7niz290il1b1vnmwfbbprbkyfgxrswybw7nzg5m1n";
    };

  nix-shell = pkgs.fetchgit {
      url = "https://github.com/chisui/zsh-nix-shell";
      rev = "82ca15e638cc208e6d8368e34a1625ed75e08f90";
      sha256 = "1l99ayc9j9ns450blf4rs8511lygc2xvbhkg1xp791abcn8krn26";
    };

  omz_custom_plugins_path = "${config.home.homeDirectory}/.oh-my-zsh/custom/plugins/";
  omz_custom_themes_path = "${config.home.homeDirectory}/.oh-my-zsh/custom/themes/";
  zdir = "${config.xdg.dataHome}/zsh";

in # ==================================================================================================================================================

{

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
      cat="ctpv";
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
        ### fzf-tab
        zstyle ':completion:*:git-checkout:*' sort true
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:*' fzf-preview 'ctpv $realpath'
        zstyle ':fzf-tab:*' fzf-flags '--height=100%'

        # Configures !! to automatically execute
        unsetopt HIST_VERIFY

        ### ================================================================================================================================================
        ### Custom widget ==================================================================================================================================
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
        ### Custom widget ==================================================================================================================================
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
        '';
  };

  home.packages = with pkgs; [
    oh-my-zsh
    zsh
  ];

  home.file = {
    # OMZ plugins
    "${omz_custom_plugins_path}fzf-tab".source = fzf-tab;
    "${omz_custom_plugins_path}zsh-ssh".source = zsh-ssh;
    "${omz_custom_plugins_path}nix-shell".source = nix-shell;
    "${omz_custom_themes_path}agnoster-nix.zsh-theme".source = ../../hm/dotfiles/oh-my-zsh/agnoster-nix.zsh-theme;
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
}
