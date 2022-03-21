-- TODO
-- * Setup DAP (debugger)

vim.o.runtimepath = "/Users/bruce.wang/dotfiles/nvim/," .. vim.o.runtimepath

print(vim.o.runtimepath)

vim.g.mapleader = " "

require("configs.general")
require("plugins")
require("configs.theme")
require("configs.remaps")
