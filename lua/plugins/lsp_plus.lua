return {

{
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
        require('tiny-inline-diagnostic').setup()
        vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end,
},
  {
    "icholy/lsplinks.nvim",
    setup = function()
      local lsplinks = require "lsplinks"
      lsplinks.setup()
      vim.keymap.set("n", "gx", lsplinks.gx)
    end,
  },

  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --     -- Disable virtual_text since it's redundant due to lsp_lines.
  --     vim.diagnostic.config {
  --       virtual_text = false,
  --     }
  --   end,
  -- },
  --
  --  {
  --    "someone-stole-my-name/yaml-companion.nvim",
  --    dependencies = {
  --      { "nvim-lua/plenary.nvim" },
  --      { "nvim-telescope/telescope.nvim" },
  --    },
  --    config = function()
  --      require("telescope").load_extension "yaml_schema"
  --      require("yaml-companion").setup()
  --    end,
  --  },

  { "kevinhwang91/nvim-bqf" },
}
