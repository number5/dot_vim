local null_ls = require "null-ls"

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.code_actions.gitsigns,
  -- null_ls.builtins.completion.spell,

  -- null_ls.builtins.diagnostics.eslint,
  null_ls.builtins.diagnostics.write_good,

  -- null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.formatting.black,
}

null_ls.setup {
  sources = sources,
  on_attach = function()
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  end,
}