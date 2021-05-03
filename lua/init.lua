require "configs.lualine"
require "configs.sumneko"

-- lspconfig object
local lspconfig = require'lspconfig'

-- Enable rust_analyzer
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
