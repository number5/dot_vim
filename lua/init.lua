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
