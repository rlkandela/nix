_: {
  flake.lib.mkNvimSettings = {
    lib,
    pkgs,
    theme,
  }: {
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      ripgrep
      fzf
      isort
      pyright
      nerd-fonts.jetbrains-mono
      lazygit
    ];

    startPlugins = [
      pkgs.vimPlugins.telescope-fzf-native-nvim
    ];

    luaConfigRC.telescopeFzf = ''
      vim.schedule(function()
        require("telescope").setup({
          defaults = {
            path_display = { "truncate" },
            layout_strategy = "horizontal",
            layout_config = {
              width = 0.97,
              horizontal = { preview_width = 0.4 },
            },
          },
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
          },
        })
        pcall(require("telescope").load_extension, "fzf")
      end)
    '';

    clipboard = {
      enable = true;
      registers = "unnamedplus";
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      updatetime = 250;
      foldlevel = 99;
      foldlevelstart = 99;
      exrc = true;
      secure = true;
    };

    lineNumberMode = "relNumber";
    preventJunkFiles = true;
    enableLuaLoader = true;

    theme = {
      inherit (theme) enable name style transparent;
    };

    statusline.lualine = {
      enable = true;
      theme = "onedark";
      activeSection = {
        b = [
          "{ 'filetype', icon_only = true }"
          "{ 'filename', path = 4 }"
        ];
        c = [];
        x = [
          "{ 'diagnostics', symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' } }"
        ];
        y = [
          "{ 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } }"
          "{ 'branch', icon = '' }"
        ];
      };

      sectionSeparator = {
        left = "";
        right = "";
      };

      integrations.breadcrumbs = {
        nvim-navic.enable = true;
        navbuddy.enable = true;
      };
    };

    tabline.nvimBufferline.enable = true;

    dashboard.alpha.enable = true;

    notify.nvim-notify.enable = true;
    ui = {
      borders.enable = true;
      noice = {
        enable = true;

        setupOpts = {
          lsp.progress.enabled = false;
        };
      };
      colorizer.enable = true;
      modes-nvim.enable = false;
      illuminate.enable = true;
      smartcolumn = {
        enable = true;
        setupOpts.colorcolumn = "100";
      };
      fastaction.enable = true;
    };

    visuals = {
      nvim-web-devicons.enable = true;
      indent-blankline.enable = true;
      cellular-automaton.enable = false;
      fidget-nvim = {
        enable = true;

        setupOpts = {
          progress.ignore = ["null-ls"];
        };
      };
    };

    filetree.neo-tree.enable = true;
    telescope.enable = true;
    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
      context = {
        enable = true;
        setupOpts = {
          max_lines = 1;
          multiline_threshold = 1;
        };
      };
      textobjects.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      trouble.enable = true;
      nvim-docs-view.enable = true;
      mappings = {
        goToDefinition = "gd";
        goToDeclaration = "gD";
        goToType = "gy";
        listImplementations = "gi";
        listReferences = "gr";

        hover = "K";
        signatureHelp = "<leader>k";

        codeAction = "<leader>ca";
        renameSymbol = "<leader>rn";

        listDocumentSymbols = "<leader>ds";
      };
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      nix.enable = true;
      go.enable = true;
      java.enable = true;
      lua.enable = true;
      bash.enable = true;
      markdown.enable = true;
      yaml.enable = true;
      typescript.enable = true;
      html.enable = true;
      css.enable = true;
      sql.enable = true;
      rust.enable = false;

      python = {
        enable = true;
        lsp = {
          enable = true;
          servers = ["basedpyright"];
        };
        format = {
          enable = true;
          type = ["isort" "ruff"];
        };
      };
    };

    autocomplete.nvim-cmp.enable = true;
    snippets.luasnip.enable = true;

    git = {
      enable = true;
      gitsigns.enable = true;
      gitsigns.codeActions.enable = true;
    };

    comments.comment-nvim.enable = true;
    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };
    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;

      setupOpts = {
        direction = "float";

        float_opts = {
          width = lib.generators.mkLuaInline ''
            function()
              return math.floor(vim.o.columns * 0.97)
            end
          '';
          height = lib.generators.mkLuaInline ''
            function()
              return math.floor(vim.o.lines * 0.97)
            end
          '';
        };
      };
    };
    autopairs.nvim-autopairs.enable = true;
    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
    diagnostics = {
      enable = true;
      config = {
        virtual_text = false;
        virtual_lines = true;
      };
    };

    keymaps = [
      {
        key = "<leader>e";
        mode = "n";
        action = "<cmd>Neotree toggle<CR>";
        silent = true;
        desc = "Toggle file tree";
      }
      {
        key = "<leader>ff";
        mode = "n";
        action = "<cmd>Telescope find_files<CR>";
        silent = true;
        desc = "Find files";
      }
      {
        key = "<leader>fg";
        mode = "n";
        action = "<cmd>Telescope live_grep<CR>";
        silent = true;
        desc = "Live grep";
      }
      {
        key = "<leader>fb";
        mode = "n";
        action = "<cmd>Telescope buffers<CR>";
        silent = true;
        desc = "Buffers";
      }
      {
        key = "<C-h>";
        mode = "n";
        action = "<C-w>h";
        silent = true;
        desc = "Window left";
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "<C-w>j";
        silent = true;
        desc = "Window down";
      }
      {
        key = "<C-k>";
        mode = "n";
        action = "<C-w>k";
        silent = true;
        desc = "Window up";
      }
      {
        key = "<C-l>";
        mode = "n";
        action = "<C-w>l";
        silent = true;
        desc = "Window right";
      }
      {
        key = "<Tab>";
        mode = "n";
        action = "<cmd>BufferLineCycleNext<CR>";
        silent = true;
        desc = "Next buffer";
      }
      {
        key = "<S-Tab>";
        mode = "n";
        action = "<cmd>BufferLineCyclePrev<CR>";
        silent = true;
        desc = "Previous buffer";
      }
      {
        key = "<leader>bx";
        mode = "n";
        action = "<cmd>bdelete<CR>";
        silent = true;
        desc = "Close buffer";
      }
      {
        key = "<leader>xX";
        mode = "n";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        silent = true;
        desc = "Toggle diagnostics [trouble]";
      }
      {
        key = "<leader>xx";
        mode = "n";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
        silent = true;
        desc = "Toggle buffer diagnostics [trouble]";
      }
      {
        key = "<leader>tt";
        mode = "n";
        action = "<cmd>ToggleTerm<CR>";
        silent = true;
        desc = "Toggle terminal";
      }
      {
        key = "<Esc><Esc>";
        mode = "t";
        action = "<C-\\><C-n>";
        silent = true;
        desc = "Exit terminal mode";
      }
    ];
  };
}
