{ inputs, ... }:
let
  comp = "zshell";
  members = [ "kyle" ];
in
{
  flake.homeModules.${comp} = { config, pkgs, ... }:
  let
    zdir = "${config.xdg.dataHome}/zsh";

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

    omz_custom_plugins_path = "${config.home.homeDirectory}/.oh-my-zsh/custom/plugins/";
    omz_custom_themes_path = "${config.home.homeDirectory}/.oh-my-zsh/custom/themes/";

    fzf-tab = pkgs.fetchgit {
        url = "https://github.com/Aloxaf/fzf-tab";
        rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
        sha256 = "0hv21mp6429ny60y7fyn4xbznk31ab4nkkdjf6kjbnf6bwphxxnk"; };

    nix-shell = pkgs.fetchgit {
        url = "https://github.com/chisui/zsh-nix-shell";
        rev = "82ca15e638cc208e6d8368e34a1625ed75e08f90";
        sha256 = "1l99ayc9j9ns450blf4rs8511lygc2xvbhkg1xp791abcn8krn26"; };
  in
  {
    programs.zsh = {
      syntaxHighlighting.enable = true;
      history.path = "${zdir}/.zsh_history";
      dotDir = "${config.home.homeDirectory}/.local/share/zsh";
      enable = true;
      shellAliases = {

        # nixos configs
        nocd="cd /etc/nixos";

        # home-manager
        hm="home-manager";
        hmcd="cd ~/.config/home-manager/";
        hmsw="HMPROFILE=$(cat $HOME/.config/home-manager/.profile) hmpr"; # TODO: make hmpr enabled and make this conditional between hmpr/home-manager
        hmbu="home-manager build"; # TODO: Expand hmpr to take build as a argument

        # convenience
        fdbench = "time fd --type d . / --max-depth 1 | parallel time fd . {}|grep ^fd"; # Benchmarks the high performance search of fzf
        src="export __HM_ZSH_SESS_VARS_SOURCED='' && source ${zdir}/.zshenv";
        sshrc="cd ~/.config/home-manager/modules/ssh && agenix -e sshconfig.age && cd -";
        ll="eza -lhg --group-directories-first";
        l="eza -g --group-directories-first";
        lla="eza -lhag --group-directories-first";
        la="eza -ag --group-directories-first";
        ff="fastfetch";
        cat="bat -p";
        myip="curl api.ipify.org";
        cl="clear";
      };

      oh-my-zsh = { enable = true; theme = "agnoster-nix"; plugins = [
          "vi-mode"
          "aliases"
          "fzf"
          "nix-shell"
          "sudo"
          "themes"
          "fzf-tab"
          "virtualenv"
          "zsh-ssh"
        ];
      };

      initContent = ''
        ### fzf-tab =============================================
        zstyle ':completion:*:git-checkout:*' sort true
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:*' fzf-preview '${pkgs.ctpv}/bin/ctpv $realpath'
        zstyle ':fzf-tab:*' fzf-flags '--height=100%'

        ### zsh options =========================================
        # Configures !! to automatically execute
        unsetopt HIST_VERIFY

        ### systemd one-time triggers
        systemctl restart --user agenix

      ''; # TODO: The systemd trigger is to fix an issue with secret deployment, move to a activateSecrets.nix module
    };

    home.packages = with pkgs; [ # These are dependencies for zshell to work correctly
      oh-my-zsh
      zsh
      python313
      #go # I can likely remove this
    ];

    home.file = {
      "${omz_custom_plugins_path}fzf-tab".source = fzf-tab;
      "${omz_custom_plugins_path}nix-shell".source = nix-shell;
      "${omz_custom_themes_path}agnoster-nix.zsh-theme".source = ./agnoster-nix.zsh-theme;
    };

    home.sessionVariables = {
      ZSH_CUSTOM="${config.home.homeDirectory}/.oh-my-zsh/custom";
      FZF_DEFAULT_COMMAND=rootsearch;
      FZF_DEFAULT_OPTS="--height=100% --reverse";

      HYPHEN_INSENSITIVE="true";
      COMPLETION_WAITING_DOTS="true";

      # Ctrl + T pastes the selected path to the CLI where your cursor is
      FZF_CTRL_T_COMMAND=homesearch;
      FZF_CTRL_T_OPTS="--preview 'ctpv {}'";

      # ALT + C cd's to the selected entry
      # By Default it searches your current Directory and cd's to the directory you select
      FZF_ALT_C_COMMAND=dhomesearch;
      FZF_ALT_C_OPTS="--preview 'ctpv {}'";

      # CTRL + R Replaces your current entry with the selected result
      # By default it searches your history, it inlcudes your current entry with what you've typed already
      #export FZF_CTRL_R_COMMAND=""
      #export FZF_CTRL_R_OPTS=""
    };
  };
}
