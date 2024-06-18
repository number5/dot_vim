-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable expandtab for Makefile
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "make" },
  callback = function()
    vim.bo[0].expandtab = false -- Use tabs for indentation
  end,
})
