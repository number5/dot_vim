require "configs.feline"
require "configs.sumneko"
require "configs.telescope"
require "configs.null-ls"

-- lspconfig object
local lspconfig = require "lspconfig"

-- Enable rust_analyzer
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.jedi_language_server.setup {}
lspconfig.terraformls.setup {
  cmd = { "terraform-ls", "serve" },
}

-- rainbow
require("nvim-treesitter.configs").setup {
  rainbow = {
    enable = true,
  },
}

-- lsp_lines
require("lsp_lines").register_lsp_virtual_lines()

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config {
  virtual_text = false,
}
