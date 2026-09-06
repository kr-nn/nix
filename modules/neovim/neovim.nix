{ inputs, ... }: {

  flake.homeModules.neovim = { pkgs, ... }: {

  home.packages = with pkgs; [
    zip
    unzip
    gcc
    cargo
  ];

  programs.nixvim.nixpkgs.pkgs = import inputs.nixpkgs { system = "x86_64-linux"; }; # silences an error on build

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
      # Tabs
      { key = "<C-l>";                mode = "n";  action = "<cmd>tabn<CR>";               options = { desc = "Switch to next tab"; }; }
      { key = "<C-h>";                mode = "n";  action = "<cmd>tabp<CR>";               options = { desc = "Switch to previous tab"; }; }
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
      gitsigns = { enable = true; settings = {
        signs = {
          add = { text = "+"; };
          change = { text = "~"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; }; }; }; };
      lsp-lines.enable = true;
      comment.enable = true; # keymaps for commenting parts of the buffer
      lualine.enable = true; # nicer status line at the bottom
      sleuth.enable = true; # automatically adjust spacing at newlines
      web-devicons.enable = true; # icons for ui
      todo-comments = { enable = true; }; # highlight Comments
      which-key = { enable = true; }; # keymap ui at bottom # Needs configuring

      # Autocomplete
      cmp = { enable = true; settings = {
        sources = [ { name = "nvim_lsp"; } { name = "path"; } ];
        mapping = {
          "<M-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's', 'c'})";
          "<M-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's', 'c'})";
          "<M-q>" = "cmp.mapping.close()";
          "<CR>"  = "cmp.mapping.confirm({ select = true })"; }; }; };

      # Language Servers
      lsp = { enable = true; inlayHints = true;
        capabilities = "require('cmp_nvim_lsp').default_capabilities()";
        servers = {
          bashls = { enable = true; };
          nixd = { enable = true;
            #settings.options.nixd.home-manager.expr = "(builtins.getFlake (toString ./.)).homeConfigurations.kyle.options";
            #settings.options.nixd.nixos.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.$HOSTNAME.options";
            #settings.options.nixd.flake_parts.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.$USER.options";
          };
          gopls = { enable = true; }; };
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
      }) '';
    };
  };
}
