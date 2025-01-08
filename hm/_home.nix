{ config, pkgs, allPkgs, lib, ... }:
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

# puzzle pieces
plasma = lib.mkMerge [ dotfilesPlasma packagesPlasma { stylix.enable = true; } yakuakeskinDark fontFiraMono ];
x11 = lib.mkMerge [ packagesGui ];
work = lib.mkMerge [ gitWork ];
laptop = lib.mkMerge [ dotfilesTouchegg ];

# Devices
framework = lib.mkMerge [ ksplashFramework plasma laptop x11 ];

Default = lib.mkMerge [ zshDefault sshDefault secretsDefault gitDefault packagesDefault envDefault meta dotfilesNeovim ];
activeProfiles = { # NOTE: Only activate some of these profiles when making tests and building home-manager, building all of them takes a long time

  # Default = lib.mkMerge [ zshDefault secretsDefault gitDefault packagesDefault envDefault meta dotfilesNeovim ];
  specialisation.Work.configuration                                  = lib.mkMerge [ work ];
  specialisation.framework.configuration                             = lib.mkMerge [ (genTheme themePink) framework ];
  specialisation.framework-work.configuration                        = lib.mkMerge [ (genTheme themeGreen) framework work ];

  #specialisation.test.configuration                                  = lib.mkMerge [ ];
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
      credential.helper = "store";
      safe.directory = "/etc/nixos"; };};};

# SSH ==============================================================

sshDefault = {
  age.secrets.id.file = ../secrets/id_ed25519.age;
  age.secrets.sshconfig.file = ../secrets/sshconfig.age;
  age.secrets.id.path = "${config.home.homeDirectory}/.ssh/id_ed25519";
  age.secrets.sshconfig.path = "${config.home.homeDirectory}/.ssh/config"; };

# Packages =========================================================
packagesPlasma = {
  home.packages = with pkgs; [
    libsForQt5.kwallet-pam ];};

packagesGui = { home.packages = with pkgs; [
  # docs
  obsidian onlyoffice-bin
  # System Packages
  kdePackages.partitionmanager
  # Social
  vesktop telegram-desktop allPkgs.pkgs-signal.signal-desktop
  # admin things
  bitwarden-desktop allPkgs.pkgs-stable.rustdesk yakuake
  # Fonts
  nerd-fonts.fira-code
  # Browser
  allPkgs.pkgs-vivaldi.vivaldi allPkgs.pkgs-vivaldi.vivaldi-ffmpeg-codecs allPkgs.pkgs-vivaldi.widevine-cdm
  # Entertainment
  mpv feishin steam ];};

packagesDefault = { home.packages = with pkgs; [
  # Shell tools
  tmux bat fzf fd parallel ctpv eza ripgrep age git curl nmap fastfetch usbutils pciutils htop jq
  # Terminal Apps
  bitwarden-cli glow
  # Neovim
  zip unzip gcc cargo
  # Nix things
  nix-prefetch-git nixd
  # aliases
  (pkgs.writeShellScriptBin "flink" (builtins.readFile ./scripts/flink) )
  (pkgs.writeShellScriptBin "hmpr"  (builtins.readFile ./scripts/hmpr) )


  (pkgs.writeShellScriptBin "no"    ''nixos-rebuild'')
  (pkgs.writeShellScriptBin "nosw"  ''nixos-rebuild switch'')
  (pkgs.writeShellScriptBin "note"  ''nixos-rebuild test'')
  (pkgs.writeShellScriptBin "nobo"  ''nixos-rebuild boot'')
  (pkgs.writeShellScriptBin "nobu"  ''nixos-rebuild build'')

  (pkgs.writeShellScriptBin "ns"    ''nix search github:nixos/nixpkgs '')
  (pkgs.writeShellScriptBin "nr"    ''nix run github:nixos/nixpkgs#"$1" -- ''${@:2}'')
  (pkgs.writeShellScriptBin "nsh"    ''nix shell github:nixos/nixpkgs#"$1" -- ''${@:2}'')
  (pkgs.writeShellScriptBin "nri"   ''nix run github:nixos/nixpkgs#"$1" --impure -- ''${@:2}'')
  (pkgs.writeShellScriptBin "nshi"   ''nix shell github:nixos/nixpkgs#"$1" --impure -- ''${@:2}'') ];};

envDefault = {
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";  }; }; # for nri/nsi impure running/shells

meta = { # Things home-manager needs to do the things I need
  programs.home-manager.enable = true;
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
    "${config.home.homeDirectory}/.config/systemsettingsrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/systemsettingsrc";
    "${config.home.homeDirectory}/.config/kglobalshortcutsrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/kglobalshortcutsrc";
    "${config.home.homeDirectory}/.config/mimeapps.list".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/mimeapps.list";
    "${config.home.homeDirectory}/.config/khotkeysrc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/khotkeysrc"; }; };

#dotfilesNeovim = {
#  home.file = {
#    "${config.home.homeDirectory}/.config/nvim/init.lua".source = ../hm/dotfiles/nvim/init.lua;
#    "${config.home.homeDirectory}/.config/nvim/lazy-lock.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/hm/dotfiles/nvim/lazy-lock.json"; }; };
dotfilesNeovim = {
  programs.nixvim = {
    /* mapping rules
      ALT for navigation
      Shift for alternative behavior (shifting open buffers instead of splits)
      leader for mode-switching (opening telescope)
      ctrl for LSP functions
    */
    enable = true;
    defaultEditor = true;
    vimdiffAlias = true;
    viAlias = true;
    vimAlias = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };
    opts = {
      number = true;
      relativenumber = true;
      mouse = ""; # enable mouse controls for resizing splits
      #showmode = true; # toggle for statusline
      clipboard = "unnamedplus";
      breakindent = true; # ???
      wrap = false;
      undofile = true; # Saves undo history; persist undo across :q
      ignorecase = true; # searches ignore case
      smartcase = true; # ???
      signcolumn = "yes"; # ???
      updatetime = 250; # don't know why im decreasing updatetime;
      timeoutlen = 300; # ???
      splitright = true; # split default direction
      splitbelow = true; # split default direction
      list = true; # ???
      listchars = { tab = "| "; trail = "_"; nbsp = "␣"; }; # ???
      inccommand = "split"; # ???
      cursorline = true; # ???
      scrolloff = 15; # Number of lines to be above/below cursor before scrolling happens
      hlsearch = true; # highlight search matches
    };
    keymaps = [
      # hlsearch clear highlight
      { key = "<Esc>";                mode = "n";  action = "<cmd>nohlsearch<CR>";         options = { desc = "Clears highlight when pressing Esc"; }; }

      # Saving/closing
      { key = "<leader>qq";           mode = "n";  action = "<cmd>q<CR>";                  options = { desc = "Close neovim"; }; }
      { key = "<leader>q";            mode = "n";  action = "<cmd>bd<CR>";                 options = { desc = "Close current buffer"; }; }
      { key = "<leader><Enter>";      mode = "n";  action = "<cmd>w<CR>";                  options = { desc = "Save current buffer"; }; }

      # Terminal mode
      { key = "<leader>t";            mode = "n";  action = "<cmd>term<CR>";               options = { desc = "Open Terminal Buffer"; }; }
      { key = "<leader>q";            mode = "t";  action = "<C-\\><C-n>";                 options = { desc = "Enter normal mode in terminal"; }; }

      # Disable arrows
      { key = "<left>";               mode = "n";  action = "";                            options = { desc = "Disable mouse direction"; }; }
      { key = "<right>";              mode = "n";  action = "";                            options = { desc = "Disable mouse direction"; }; }
      { key = "<up>";                 mode = "n";  action = "";                            options = { desc = "Disable mouse direction"; }; }
      { key = "<down>";               mode = "n";  action = "";                            options = { desc = "Disable mouse direction"; }; }

      ## navigation
      # Windows
      { key = "<M-h>";                mode = "n";  action = "<C-w><C-h>";                  options = { desc = "Move focus to the left window"; }; }
      { key = "<M-l>";                mode = "n";  action = "<C-w><C-l>";                  options = { desc = "Move focus to the right window"; }; }
      { key = "<M-j>";                mode = "n";  action = "<C-w><C-j>";                  options = { desc = "Move focus to the lower window"; }; }
      { key = "<M-k>";                mode = "n";  action = "<C-w><C-k>";                  options = { desc = "Move focus to the upper window"; }; }
      # Buffers
      { key = "<M-S-l>";              mode = "n";  action = "<cmd>bnext<CR>";              options = { desc = "Next Buffer"; }; }
      { key = "<M-S-h>";              mode = "n";  action = "<cmd>bprev<CR>";              options = { desc = "Previous Buffer"; }; }
      # Command mode
      { key = "<M-k>";                mode = "c";  action = "<Up>";                        options = { desc = "Scroll up in vim command history"; }; }
      { key = "<M-j>";                mode = "c";  action = "<Down>";                      options = { desc = "Scroll down in vim command history"; }; }
      # Jumplist
      { key = "<M-S-k>";              mode = "n";  action = "<C-I>";                       options = { desc = "Jump to previous Jump in jumplist"; }; }
      { key = "<M-S-j>";              mode = "n";  action = "<C-O>";                       options = { desc = "Jump to next Jump in jumplist"; }; }
      # undo list TODO

      ## Oil
      #{ key = "<leader>o";            mode = "n";  action = "<cmd>Oil<CR>";                options = { desc = "Open Directory structure"; }; }

    ];
    autoCmd = [
      # highlight text when yanking
      { event = "TextYankPost"; group = "highlight-yank"; callback = { __raw = "function() vim.highlight.on_yank() end"; }; desc = "Highlight when yanking text"; }
    ];
    autoGroups = {
      # highlight text when yanking
      highlight-yank = { clear = true; };
    };

    plugins = {
      #lazy = { enable = true; };
      #oil.enable = true; # filemanager
      #statuscol.enable = true; # Line status on left # Needs configuring
      #fugitive.enable = true; # swiss army git plugin # Needs configuring
      #gitsigns = { enable = true; settings = {
      #  signs = {
      #    add = { text = "+"; };
      #    change = { text = "~"; };
      #    delete = { text = "_"; };
      #    topdelete = { text = "‾"; };
      #    changedelete = { text = "~"; }; }; }; };
      comment.enable = true; # keymaps for commenting parts of the buffer
      lualine.enable = true; # nicer status line at the bottom
      sleuth.enable = true; # automatically adjust spacing at newlines
      web-devicons.enable = true; # icons for ui
      todo-comments = { enable = true; }; # highlight Comments
      which-key = { enable = true; }; # keymap ui at bottom # Needs configuring

      # Autocomplete
      cmp = { enable = true; settings = {
        sources = [ { name = "nvim_lsp"; } ];
        mapping = {
          "<M-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's', 'c'})";
          "<M-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's', 'c'})";
          "<M-q>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ select = true })"; }; }; };

      # Language Servers
      lsp = { enable = true; inlayHints = true;
        capabilities = "require('cmp_nvim_lsp').default_capabilities()";
        servers = {
          nixd = { enable = true; }; };
        keymaps = {
          lspBuf = {
            "<C-r>" = "rename"; # Rename a symbol
            "<C-q>" = "code_action"; # show code actions
            "<C-t>" = "hover";  }; }; }; # Show type

      # Fuzzy Finder
      telescope = { enable = true;
        settings = {
          # Telescope use Alt + j/k to move option
          defaults.mappings.i = {
            "<leader>q".__raw = "require('telescope.actions').close";
            "<M-k>".__raw = "require('telescope.actions').move_selection_previous";
            "<M-j>".__raw = "require('telescope.actions').move_selection_next"; };
          pickers = {
            find_files = {
              hidden = true; cwd = "."; }; }; };
        keymaps = {
          # Search
          "<leader>sh"       = { action = "help_tags";                          options = { desc = "[S]earch [H]elp"; }; };
          "<leader>sk"       = { action = "keymaps";                            options = { desc = "[S]earch [K]eymaps"; }; };
          "<leader>sf"       = { action = "find_files";                         options = { desc = "[S]earch [F]iles"; }; };
          "<leader>ss"       = { action = "builtin";                            options = { desc = "[S]earch [S]elect Telescope"; }; };
          "<leader>sw"       = { action = "grep_string";                        options = { desc = "[S]earch current [W]ord"; }; };
          "<leader>sq"       = { action = "loclist";                            options = { desc = "[S]earch [Q]uickfix list"; }; };
          "<leader>sg"       = { action = "live_grep";                          options = { desc = "[S]earch by [G]rep"; }; };
          "<leader>sd"       = { action = "diagnostics";                        options = { desc = "[S]earch [D]iagnostics"; }; };
          "<leader>sr"       = { action = "resume";                             options = { desc = "[S]earch [R]esume"; }; };
          "<leader>s."       = { action = "oldfiles";                           options = { desc = "[S]earch Recent Files ('.' for repeat)"; }; };
          "<leader><leader>" = { action = "buffers";                            options = { desc = "[S]earch Buffers"; }; };
          "<leader>/"        = { action = "current_buffer_fuzzy_find";          options = { desc = "[/] Fuzzy search in current buffer"; }; };

          # DNY
          #"<leader>td"       = { action = "lsp_type_definitions";               options = { desc = "Type [D]efinition"; }; };
          #"<leader>ds"       = { action = "lsp_document_symbols";               options = { desc = "[D]ocument [S]ymbols"; }; };
          #"<leader>ws"       = { action = "lsp_dynamic_workspace_symbols";      options = { desc = "[W]orkspace [S]ymbols"; }; };

          # Go To
          "<leader>gd"       = { action = "lsp_definitions";                    options = { desc = "[G]oto [D]efinition"; }; };
          "<leader>gr"       = { action = "lsp_references";                     options = { desc = "[G]oto [R]eferences"; }; };
          "<leader>gi"       = { action = "lsp_implementations";                options = { desc = "[G]oto [I]mplementation"; }; }; };

        extensions = { ui-select.enable = true; undo.enable = true; }; };

      # Syntax Highligher
      treesitter = { enable = true;
        languageRegister = {
          nix = "nix";
          markdown = "md";
          python = [ "py" ];
          bash = "sh";
          html = "html"; }; }; };

    # Out of band configuration
    extraConfigLua = ''
      require("which-key").add({
        { "<leader>c", desc = "[C]ode" },
        { "<leader>d", desc = "[D]ocument" },
        { "<leader>s", desc = "[S]earch" },
        { "<leader>e", desc = "[E]rrors" },
        { "<leader>w", desc = "[W]orkspace" },
        { "<leader>g", desc = "[G]oto Things" },
      }) ''; }; };

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
  programs.carapace = { enable = true; enableZshIntegration = true; };
  programs.bash = { enable=true; initExtra = "zsh"; historyFile = "${zdir}/bash_history"; }; # change shell to zsh when in a bash shell
  programs.zsh = {
    syntaxHighlighting.enable = true;
    history.path = "${zdir}/.zsh_history";
    dotDir = ".local/share/zsh";
    enable = true;
    shellAliases = {
      # neovim
      vimrc="$EDITOR ~/.config/home-manager/hm/dotfiles/nvim/init.lua";

      # nixos configs
      nocd="cd /etc/nixos";
      norc="nocd && $EDITOR /etc/nixos/hosts/$(cat /etc/hostname)/configuration.nix && cd -";
      noll="ll /etc/nixos";

      # home-manager
      hm="home-manager";
      hmcd="cd ~/.config/home-manager/";
      hmll="ll ~/.config/home-manager/";
      hmrc="hmcd && $EDITOR ~/.config/home-manager/hm/_home.nix && cd -";
      hmsw="home-manager switch -b ~/.hmbak";
      hmbu="home-manager build -b ~/.hmbak";

      # convenience
      fdbench = "time fd --type d . / --max-depth 1 | parallel time fd . {}|grep ^fd"; # Benchmarks the high performance search of fzf
      src="source ${zdir}/.zshrc";
      sshrc="cd ~/.config/home-manager/secrets && agenix -e sshconfig.age && cd -";
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

    initExtra =  ''
        ### fzf-tab =============================================
        zstyle ':completion:*:git-checkout:*' sort true
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:*' fzf-preview 'ctpv $realpath'
        zstyle ':fzf-tab:*' fzf-flags '--height=100%'

        ### zsh options =========================================
        # Configures !! to automatically execute
        unsetopt HIST_VERIFY

        ### Vaultwarden init ===============================================================================================================================
        AGEPATH="/run/user/$UID/age.key"
        BWPATH="/run/user/$UID/bwsession"

        while [ -z "$session" ]; do
          if [ -n "$BW_SESSION" ]; then
            session=$BW_SESSION
          elif [ -f $BWPATH ]; then
            session=$(head -n 1 $BWPATH)
          else
            STATUS=$(bw status | jq .status)
            if [ "$STATUS" = "\"unauthenticated\"" ]; then
              bw config server https://vaultwarden.nocturnalnerd.xyz
              session=$(bw login --raw)
            elif [ "$STATUS" = "\"locked\"" ]; then
              session=$(bw unlock --raw)
            else
              echo "Something went wrong - couldn't get a session for vaultwarden"
              exit 1
            fi
          fi
        done

        echo $session > $BWPATH
        export BW_SESSION="$session"

        if ! [ -f $AGEPATH ] || [ -z "$(head -n 1 $AGEPATH)" ]; then
          echo $(bw get password af9d248c-93e9-4de4-8e15-61b5801d326c) > $AGEPATH
        fi

        if ! [ -L ~/.ssh/age.key ] && ! [ -f ~/.ssh/age.key ] && [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
          ln -s $AGEPATH ~/.ssh/age.key
        fi

        ### run on all commands =============================================================================================================================
        reloadBW(){
          if [ -f /run/user/$UID/bwsession ]; then
            export BW_SESSION=$(cat /run/user/$UID/bwsession)
          fi
          if ! [ -d /run/user/$UID/agenix ] || [ $(eza -lha /run/user/$UID/agenix | wc -l) -eq 0 ]; then
            systemctl --user start agenix
          fi
        }
        precmd_functions+=(reloadBW)

        '';
  };

  home.packages = with pkgs; [
    oh-my-zsh
    zsh
    python313
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
polarityLight = { stylix.polarity = "light"; };
polarity = { stylix.polarity = "either"; };

fontFiraMono = { stylix.fonts = { monospace.package = pkgs.nerd-fonts.fira-code; monospace.name = "nerdfonts-3.2.1"; }; };

# Wallpapers/colorschemes =============================================

genTheme = wallpaper: {
  stylix.image = wallpaper;
  stylix.polarity = lib.mkDefault "either";
  home.file.".config/kscreenlockerrc".text = ''
    [Greeter]
    Wallpaper=org.kde.image
    WallpaperPlugin=org.kde.image
    Image=file://${wallpaper}
  '';
};

themeGreen = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
  sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3"; };

themePink = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/7p/wallhaven-7pz9v9.jpg";
  sha256 = "sha256-sqXEfndZiZ+Qt87D6NHj/0EAKXdUI+RsvlXckE6maMc="; };

themepink2 = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/gp/wallhaven-gpyq2e.png";
  sha256 = "sha256-d5uQ7BQ+tzFmx6shGpuMV6PBnUNfh7jbCRaaFxW8aNc="; };

# Spicy ===============

themePink3 = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/g8/wallhaven-g891mq.jpg";
  sha256 = "0kdzdny260klqz6mprns3641a59f652w9ppyy89dair07wb9a634"; };

themeGreen2 = pkgs.fetchurl {
  url = "https://w.wallhaven.cc/full/l8/wallhaven-l8ogop.jpg";
  sha256 = "1w8w9l1fpd7y6svfvs6p49xy2kma0cdg9r8i4lfmh66535fvmy7d"; };

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

    home.activation.secretsInit = lib.hm.dag.entryBetween ["reloadSystemd"] ["writeBoundary"] ''
      PATH="${config.home.path}/bin:$PATH:${pkgs.jq}/bin:${pkgs.bitwarden-cli}/bin"
      export AGEPATH="/run/user/$UID/age.key"
      export BWPATH="/run/user/$UID/bwsession"
      session=""
      if ! [ -d ~/.ssh ]; then
        mkdir ~/.ssh
	chmod 700 ~/.ssh
      fi

      cleanup() {
        if [ -f $BWPATH ]; then
          rm -rf $BWPATH
        fi
        if [ -f $AGEPATH ]; then
          rm -rf $AGEPATH
        fi
        if [ -L ~/.ssh/age.key ]; then
          unlink ~/.ssh/age.key
        fi
      }

      cleanup
      echo "Deploying Secrets"
      export STATUS=$(bw status | jq .status)
      while [ -z "$session" ]; do
        if [ "$STATUS" = "\"unauthenticated\"" ]; then
          bw config server https://vaultwarden.nocturnalnerd.xyz
          echo "Login to Vault:"
          session=$(bw login --raw)
        elif [ "$STATUS" = "\"locked\"" ]; then
          echo "Unlock Vault:"
          session=$(bw unlock --raw)
        elif [ "$STATUS" = "\"unlocked\"" ]; then
          echo "Already unlocked no need to unlock vault"
          echo "current key: $BW_SESSION"
          session=$BW_SESSION
        else
          echo "Something went wrong - couldn't get a session for vaultwarden"
          cleanup
          exit 1
        fi
        echo $session > $BWPATH
      done

      echo $(bw --session $session get password af9d248c-93e9-4de4-8e15-61b5801d326c) > $AGEPATH

      if [ -f $AGEPATH ] && [ -n "$(head -n 1 $AGEPATH)" ]; then
        ln -s $AGEPATH ~/.ssh/age.key
      else
        echo "Something went wrong, could not write age key to /run/user/$UID/age.key"
        cleanup
        exit 1
      fi

    '';

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
            exit
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
