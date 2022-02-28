require "configs.feline"
require "configs.sumneko"
require "configs.telescope"
require "configs.null-ls"

-- lspconfig object
local lspconfig = require'lspconfig'

-- Enable rust_analyzer
lspconfig.tsserver.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.jedi_language_server.setup{}
lspconfig.terraformls.setup{
                cmd = {'terraform-ls', 'serve'}
                }

-- rainbow
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true
  }
}

-- lsp_lines
require("lsp_lines").register_lsp_virtual_lines()

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  virtual_text = false,
})
-- compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = false;
  };
}
