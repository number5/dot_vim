-- Plugins
local plugins = {

  -- LSP
  {
    -- Autocomplete
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      --  "ray-x/lsp_signature.nvim",
      "ray-x/cmp-treesitter",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
      "weilbith/nvim-code-action-menu",
      "kosayoda/nvim-lightbulb",
    },
    config = function()
      require "config.lsp"
      require "config.lsp_cmp"
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  { "williamboman/mason-lspconfig.nvim" },

  {
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
          require("nvim-lightbulb").update_lightbulb { ignore = { "null-ls" } }
        end,
      })
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config {
        virtual_text = false,
      }
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = "ray-x/guihua.lua",
    config = function()
      require("go").setup()
    end,
    ft = { "go" },
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup {
        position = "left",
      }
    end,
  },

  -- Linting and formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    config = function()
      require "config.null-lsp"
    end,
  },

  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    config = function()
      require "config.ts-utils"
    end,
  },

  { "lukas-reineke/lsp-format.nvim" },

  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension "yaml_schema"
      require("yaml-companion").setup()
    end,
  },

  { "Vimjas/vim-python-pep8-indent" },

  { "kevinhwang91/nvim-bqf" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "p00f/nvim-ts-rainbow",
      "RRethy/nvim-treesitter-textsubjects",
    },
    build = ":TSUpdate",
    config = function()
      require "config.treesitter"
    end,
  },

  -- Debugging
  -- use 'mfussenegger/nvim-dap'
  -- use 'rcarriga/nvim-dap-ui'
  -- use 'Pocco81/DAPInstall.nvim'

  -- Quality of life enhancements
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup()
    end,
  },

  {
    -- Auto close brackets etc (with treesitter support)
    "windwp/nvim-autopairs",
    config = function()
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      local cmp = require "cmp"
      require("nvim-autopairs").setup { check_ts = true }
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done {})
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.api.nvim_set_option("timeoutlen", 600)
      require("which-key").setup()
    end,
  },
  {
    "famiu/feline.nvim",
    config = function()
      require("feline").setup()
    end,
  },

  {
    -- Draw indentation lines (highlighting based on treesitter)
    "lukas-reineke/indent-blankline.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("indent_blankline").setup {
        char_list = { "▏", "¦", "┆", "┊" },
        filetype_exclude = { "help", "packer" },
        buftype_exclude = { "terminal", "nofile" },
        show_trailing_blankline_indent = false,
      }
    end,
  },
  {
    -- Color highlighter
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- Telescope (Fuzzy finding)
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require "config.telescope_cfg"
    end,
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").set_default_keymaps()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  },
  { "stevearc/dressing.nvim" },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup {
        ring = {
          history_length = 100,
          storage = "shada",
          sync_with_numbered_registers = true,
          cancel_event = "update",
        },
        system_clipboard = {
          sync_with_ring = true,
        },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        }, -- add any options here
      }
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
}

return plugins
