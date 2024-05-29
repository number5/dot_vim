return {
  -- colorschemes
  {
    "bluz71/vim-nightfly-guicolors",
  },

  { "rebelot/kanagawa.nvim" },
  { "folke/tokyonight.nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "arturgoms/moonbow.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        nvimtree = true,
        semantic_tokens = true,
        telescope = false,
        treesitter = true,
        which_key = true,
      },
    },
  },

  { "Mofiqul/dracula.nvim" },

  -- setting colorscheme the Lazy way
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
