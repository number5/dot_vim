-- Plugins
local plugins = {
  -- Package manager
  { "wbthomason/packer.nvim" },

  -- LSP
  {
    -- Autocomplete
    "hrsh7th/nvim-cmp",
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-lua/lsp-status.nvim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/lsp_signature.nvim",
      "williamboman/nvim-lsp-installer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
      "kosayoda/nvim-lightbulb",
      "weilbith/nvim-code-action-menu",
    },
    config = function()
      require "config.lsp"
      require "config.lsp_cmp"
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua require("nvim-lightbulb").update_lightbulb()]]
    end,
  },

  { "simrat39/symbols-outline.nvim" },

  -- Linting and formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
    config = function()
      require "config.null-lsp"
    end,
  },

  { "jose-elias-alvarez/nvim-lsp-ts-utils" },

  { "lukas-reineke/lsp-format.nvim" },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").register_lsp_virtual_lines()
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config {
        virtual_text = false,
      }
    end,
  },

  { "kevinhwang91/nvim-bqf" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "p00f/nvim-ts-rainbow",
      "RRethy/nvim-treesitter-textsubjects",
    },
    run = ":TSUpdate",
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
    -- Use 'CTRL + /' to comment line or selection
    "b3nj5m1n/kommentary",
    config = function()
      vim.api.nvim_set_keymap("n", "", "<Plug>kommentary_line_default", {})
      vim.api.nvim_set_keymap("v", "", "<Plug>kommentary_visual_default<C-c>", {})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    -- Auto close brackets etc (with treesitter support)
    "windwp/nvim-autopairs",
    after = { "nvim-cmp" },
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
      vim.api.nvim_set_option("timeoutlen", 300)
      require("which-key").setup {}
    end,
  },
  {
    "famiu/feline.nvim",
    config = function()
      require("feline").setup()
    end,
  },

  -- colorscheme
  {
    "bluz71/vim-nightfly-guicolors",
  },

  { "rebelot/kanagawa.nvim" },
  {
    -- Color theme
    "mhartington/oceanic-next",
    config = function()
      vim.cmd "colorscheme OceanicNext"
      -- Fix transparent background
      vim.cmd "hi Normal guibg=NONE ctermbg=NONE"
      vim.cmd "hi LineNr guibg=NONE ctermbg=NONE"
      vim.cmd "hi SignColumn guibg=NONE ctermbg=NONE"
      vim.cmd "hi EndOfBuffer guibg=NONE ctermbg=NONE"
    end,
  },
  {
    -- Draw indentation lines (highlighting based on treesitter)
    "lukas-reineke/indent-blankline.nvim",
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

      require("indent_blankline").setup {
        char = "",
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
        },
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

  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },

  -- Telescope (Fuzzy finding)
  {
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require "config.telescope_cfg"
    end,
  },

  { "ggandor/leap.nvim" },

  { "maxbrunsfeld/vim-yankstack" },

  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },
}

return plugins
