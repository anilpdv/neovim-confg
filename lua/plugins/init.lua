return {
  {
    "kevinhwang91/nvim-ufo",
    keys = {
      { "zc", mode = "n", desc = "Fold current line" },
      { "zo", mode = "n", desc = "Unfold current line" },
      { "za", mode = "n", desc = "Toggle fold current line" },
      { "zA", mode = "n", desc = "Toggle fold all lines" },
      { "zr", mode = "n", desc = "Unfold all lines" },
      { "zR", mode = "n", desc = "Fold all lines" },
    },
    dependencies = "kevinhwang91/promise-async",
    opts = function()
      vim.o.foldenable = true -- enable folding when plugin is loaded
      return require("config.nvim-ufo")
    end,
  },
  {
    "sontungexpt/sttusline",
    branch = "develop",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "User FilePostLazyLoaded",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configure floating diagnostic box
      vim.diagnostic.config({
        float = {
          border = "rounded",
          header = "",
          prefix = "",
        },
        virtual_text = false, -- Disable inline diagnostics
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Load your LSP configurations
      require "configs.lspconfig"
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = false, -- Disable the lightbulb
          enable_in_insert = false,
        },
        ui = {
          border = "rounded",
          code_action = "💡",
        },
        hover = {
          max_width = 0.6,
          max_height = 0.6,
          open_link = 'gx',
          open_browser = '!chrome',
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup({
        keep_indentation = false,
        fill_char = '━',
        sections = {
          left = {
            '━ ', function() return string.rep('*', vim.v.foldlevel) end, ' ━┫', 'content', '┣'
          },
          right = {
            '┫ ', 'number_of_folded_lines', ': ', 'percentage', ' ┣━━',
          }
        }
      })
    end
  },
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      -- Get the cmp source configuration
      local cmp = require("cmp")

      -- Add tailwindcss-colorizer formatting
      opts.formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter
      }

      return opts
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "typescript-language-server",
        "gopls",
        "eslint-lsp",
        "lua-language-server",
        "css-lsp",
        "html-lsp",
        "angular-language-server", -- Angular LSP
        "elixir-ls",               -- Phoenix LSP

        -- Formatters
        "prettier",
        "gofumpt",
        "goimports",
        "mix", -- Elixir formatter

        -- Linters
        "eslint_d",
        "golangci-lint",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "typescript",
        "javascript",
        "tsx",
        "html",
        "css",
        "go",
        "gomod",
        "json",
        "yaml",
        "markdown",
        "heex",    -- Phoenix Heex files
        "elixir",  -- Elixir files
        "angular", -- Angular files
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- enable format on save
    opts = require "configs.conform",
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "html", "heex" }, -- Add Heex files
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          -- Use Tab for acceptance (most intuitive from VSCode/other IDEs)
          accept = "<Tab>",

          -- Use Cmd+] and Cmd+[ for next/prev (similar to MacOS tab navigation)
          -- Note: In Neovim, Cmd is mapped as D in config
          next = "<D-]>", -- Cmd+] for next suggestion
          prev = "<D-[>", -- Cmd+[ for previous suggestion

          -- Use Esc or Ctrl+] to dismiss (standard MacOS conventions)
          dismiss = "<C-]>", -- Ctrl+] to dismiss

          -- Partial acceptance options
          accept_word = "<C-l>", -- Ctrl+l to accept word (l for "little")
          accept_line = "<C-j>", -- Ctrl+j to accept line (j for "jump")
        },
      },
      -- Enable Copilot for these filetypes
      filetypes = {
        markdown = true,
        javascript = true,
        typescript = true,
        javascriptreact = true,
        typescriptreact = true,
        lua = true,
        go = true,
        python = true,
        rust = true,
        html = true,
        css = true,
        scss = true,
        json = true,
        yaml = true,
        heex = true,   -- Enable for Heex files
        elixir = true, -- Enable for Elixir files
        ["."] = true,  -- Enable for all other filetypes
        gitcommit = true,
      },
      -- Disable for these filetypes
      disable_filetypes = {
        help = true,            -- No suggestions in help files
        gitrebase = true,       -- No suggestions in git rebase
        TelescopePrompt = true, -- No suggestions in Telescope
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "NvimTree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects for better editing
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre", -- Super search and replace plugin
    config = function()
      require("spectre").setup({
        mapping = {
          ['send_to_qf'] = {
            map = "<leader>sq", -- Send search results to quickfix list
            cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
            desc = "Send all items to quickfix",
          },
        },
      })
    end,
    keys = {
      { "<leader>ss", "<cmd>lua require('spectre').open()<CR>",                          desc = "Open Spectre (Search & Replace)" },
      { "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = "Search current word" },
      { "<leader>sf", "<cmd>lua require('spectre').open_file_search()<CR>",              desc = "Search in current file" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon").setup()
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")
      vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add file" })
      vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Harpoon: Menu" })
      vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon: File 1" })
      vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon: File 2" })
    end,

  },
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup()
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git: Diffview" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git: File History" })
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        cmdline = { view = "cmdline_popup" }, -- Fancy cmdline
        lsp = { override = { "vim.lsp.util.convert_input_to_markdown_lines" } },
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- Example debugger setup for Node.js (adapt for your language)
      require("dap").adapters.node2 = { type = "executable", command = "node-debug2-adapter" }
      require("dap").configurations.javascript = {
        { type = "node2", request = "launch", name = "Launch file", program = "${file}" },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("dapui").setup()
      vim.keymap.set("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>",
        { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Debug: Start/Continue" })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({ snippet_engine = "luasnip" })
      vim.keymap.set("n", "<leader>dg", "<cmd>lua require('neogen').generate()<cr>", { desc = "Generate Docs" })
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
      vim.keymap.set("n", "<leader>so", "<cmd>SymbolsOutline<cr>", { desc = "Symbols Outline" })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- Load immediately
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        },
      })
    end
  }
  , {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabs",
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
      }
    })
  end
},

  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⠶⠞⠛⠉⠉⠉⠉⠉⠉⠉⠉⠛⠳⢦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠞⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡄⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣇⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠇⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠁⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣶⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣶⠾⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠶⠾⠟⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      }
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      alpha.setup(dashboard.config)
    end
  },


  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        timeout = 2000,
        background_colour = "#1e1e2e",
      })
      vim.notify = require("notify")
    end
  },
  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    config = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_highlight_range = 1
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        indent = { char = "▏" },
        scope = { show_start = false }
      })
    end
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
  }
}
