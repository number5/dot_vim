-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = runtime_path },
      completion = { enable = true, callSnippet = "Both" },
      diagnostics = {
        enable = true,
        globals = { "vim", "describe" },
        disable = { "lowercase-global" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        -- {
        --[vim.fn.expand "$VIMRUNTIME/lua"] = true,
        -- [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        --  [vim.fn.expand('/usr/share/awesome/lib')] = true
        --},
        -- adjust these two values if your performance is not optimal
        maxPreload = 2000,
        preloadFileSize = 1000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
