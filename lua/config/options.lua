-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.laststatus = 3
vim.o.wrap = true
vim.o.showbreak = "↪ "

vim.o.whichwrap = "<,>,[,]"
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.vimsyn_embed = "lPr"

vim.g.snacks_animate = false

require "misc.diagnostics-config"

vim.g.gruvbox_material_background = "soft"
