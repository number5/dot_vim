-- Line numbering
vim.api.nvim_win_set_option(0, "number", true)
vim.api.nvim_win_set_option(0, "relativenumber", true)
vim.api.nvim_win_set_option(0, "wrap", false)

-- Better Markdown
vim.api.nvim_set_option("conceallevel", 0)

-- Mouse
vim.api.nvim_set_option("mouse", "a")

-- Search case
vim.api.nvim_set_option("ignorecase", true)
vim.api.nvim_set_option("smartcase", true)

-- Syntax highlighting
vim.o.syntax = "enable"

-- Minimal number of lines to scroll when the cursor gets off the screen
vim.api.nvim_set_option("scrolloff", 8)
vim.api.nvim_set_option("sidescrolloff", 8)

-- Indents
vim.api.nvim_set_option("tabstop", 4)
vim.api.nvim_set_option("shiftwidth", 4)
vim.api.nvim_set_option("smartindent", true)
vim.cmd("autocmd FileType c setlocal tabstop=2 shiftwidth=2 expandtab")
vim.cmd("filetype indent plugin on")
